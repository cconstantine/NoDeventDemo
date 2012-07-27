class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Logged in!" }
        format.json { render :json => user }
      end
    else
      flash.now.alert = "Invalid email or password"
      respond_to do |format|
        format.html { render "new" }
        format.json { head :unauthorized }
      end
    end
  end

  def destroy
    reset_session

    respond_to do |format|
        format.html { redirect_to root_path, :notice => "Logged out!" }
        format.json { render :json => {}}
      end
  end

end
