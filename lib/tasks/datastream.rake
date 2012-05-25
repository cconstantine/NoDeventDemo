require 'tweetstream'

auth_conf = YAML::load(File.open("/etc/twitter.yml"))[Rails.env]

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

    trending = Set.new(Trend.order('count desc').limit(10).map &:text)
    NoDevent::Emitter.emit("trending", "updated_trending", trending) #if status.coordinates

    TweetStream::Client.new.filter(
                                   :locations => '-180,-90,180,90'
                                   
                                   )  do |status|
      begin
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
        NoDevent::Emitter.emit("tweets", "tweet", status) if (hashes & trending).any?
      rescue
        p $!
      end
    end
  end
end
