class SessionsController < ApplicationController
  respond_to :json

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      respond_to do |format|
        format.json { render :json => user }
      end
    else
      respond_to do |format|
        format.json { render :status => :unauthorized, :json => {:errors => {:login => ["Invalid email or password"]}} }
      end
    end
  end

  def destroy
    reset_session

    respond_to do |format|
      format.json { render :json => {}}
    end
  end

end
