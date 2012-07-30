class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to root_url, :notice => "Signed up!" }
        format.json { render :json =>  @user }
      end
    else
      respond_to do |format|
        format.html { render "new" }
        format.json { render :json => {:errors => errors.to_json } }
      end
    end
  end
end