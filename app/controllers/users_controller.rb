class UsersController < ApplicationController
  respond_to :json

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.new(params[:user])
    session[:user_id] = @user.id if @user.save
    respond_with @user
  end
end