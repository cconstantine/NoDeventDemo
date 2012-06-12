require 'tweetstream'
require 'twitter'

auth_conf = YAML::load(File.open("/etc/twitter.yml"))[Rails.env]

namespace :datastream  do
  desc 'Connect to twitter'
  task :auth do
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
  end

  task :userstream do
    client = TweetStream::Client.new
    
    client.userstream do |status|
      puts status.inspect
    end
  end
  task :sitestream do
    client = TweetStream::Client.new
    
    client.sitestream(['115192457'], :followings => true) do |status|
      puts status.inspect
    end
  end
  desc "create some data"
  task :firehose => [:environment, :auth] do
    
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


    TweetStream::Client.new.filter(:locations => '-180,-90,180,90')  do |status|
      begin
        next unless status.coordinates.present?
        status[:is_trending] = trending.map{|x| x if status.text.include?(x)}.compact

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
