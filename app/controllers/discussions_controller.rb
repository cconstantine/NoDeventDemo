class DiscussionsController < ApplicationController
  respond_to :json, :html

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
    @discussion.user = current_user
    @discussion.save

    respond_with @discussion
  end
end