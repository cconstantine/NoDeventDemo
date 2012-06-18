class PublicController < ApplicationController

  def show
    #session[:user] ||= {:name => ActiveSupport::SecureRandom.hex(16)}
    @user = session[:user]
    @trends = $redis.get('twitter:trends')
  end

  def create
    NoDevent::Emitter.emit(
                           'theroom',
                           'location',
                           { :user => session[:user],
                             :loc  => params[:loc]}) 
    render :text => 'OK'
  end
end
