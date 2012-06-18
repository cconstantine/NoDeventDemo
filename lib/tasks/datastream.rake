require 'tweetstream'
require 'twitter'

auth_conf = YAML::load(File.open("/etc/twitter.yml"))[Rails.env]

=begin
             hashes = status.entities.hashtags.map do |hashtag|
          hash = (hashtag["text"].downcase)
          trend = Trend.find_or_create_by_text hash
          trend.count += 1 
          trend.save!
          
          if trend.count > 100
            Trend.update_all('count = count / 2')
            Trend.where(:count => 0).delete_all
            
            trending = Set.new(Trend.order('count desc').limit(10).map &:text)
            NoDevent::Emitter.emit("trending", "updated_trending", trending)
          end
          hash
        end.to_set
=end

namespace :datastream  do
  desc "create some data"
  task :firehose => :environment do
    require 'trend'

    TweetStream.configure do |config|
      config.consumer_key =       auth_conf['consumer_key']
      config.consumer_secret =    auth_conf['consumer_secret']
      config.oauth_token =        auth_conf['oauth_token']
      config.oauth_token_secret = auth_conf['oauth_token_secret']
      config.auth_method = :oauth
      config.parser   = :yajl
    end

    Twitter.configure do |config|
      config.consumer_key =       auth_conf['consumer_key']
      config.consumer_secret =    auth_conf['consumer_secret']
      config.oauth_token =        auth_conf['oauth_token']
      config.oauth_token_secret = auth_conf['oauth_token_secret']
    end
    
    def update_trending
      trending = Twitter.trends
      $redis.set("twitter:trends", trending.to_json)
      NoDevent::Emitter.emit("twitter", "trends", trending)

      trending = trending.map &:name
      p trending
      return trending
    end

    time = Time.now
    trending = update_trending
    
    TweetStream::Client.new.on_error do |message|
      p message
    end.filter(:locations => '-180,-90,180,90')  do |status|
      begin
        next unless status.geo.try(:coordinates).present?
        
        s = status.as_json
        s[:is_trending] = trending.map{|x| x if status.text.include?(x)}.compact

        NoDevent::Emitter.emit("twitter", "tweet", status)
        if time + 5.minutes < Time.now
          trending = update_trending
          time = Time.now
        end
      rescue
        p $!
      end
    end
  end
end
