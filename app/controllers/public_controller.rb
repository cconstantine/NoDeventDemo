class PublicController < ApplicationController

  def show
    #session[:user] ||= {:name => ActiveSupport::SecureRandom.hex(16)}
    @user = session[:user]
    @trends = $redis.get('twitter:trends')
  end
end
