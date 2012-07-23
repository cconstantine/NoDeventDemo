class DiscussionsController < ApplicationController
  def new
    @discussion = Discussion.new.reverse
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
    if @discussion.save
      respond_to do |format|
        format.html { redirect_to discussion_path(@discussion) }
        format.json { render :json =>  @discussion }
      end
    else
      respond_to do |format|
        format.html { render "new"}
        format.json { render :json =>  @discussion }
      end
    end
  end
end