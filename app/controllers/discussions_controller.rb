class DiscussionsController < ApplicationController
  def new
    @discussions = Discussion.order('id desc').limit(10).reverse
    @discussion  = Discussion.new()
  end

  def show
    @discussion = Discussion.find params[:id]
    respond_to do |format|
      format.html {  }
      format.json { render :json =>  @discussion }
    end
  end

  def create
    @discussion = Discussion.new(params[:discussion])

    if current_user.present?
      @discussion.user = current_user
    end
    if @discussion.save
      respond_to do |format|
        format.html { redirect_to discussion_path(@discussion) }
        format.json { render :json =>  @discussion }
      end
    else
      respond_to do |format|
        format.html { render "new"}
        format.json { render :status => :unauthorized, :json =>  @discussion }
      end
    end
  end
end