class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(:username => params[:username], :password => params[:password])
    if @user.save
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to root_url, :notice => "Signed up!" }
        format.json { render :json =>  @user }
      end

    else
      render "new"
    end
  end
end