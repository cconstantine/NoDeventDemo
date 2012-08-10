class DiscussionsController < ApplicationController
  respond_to :json, :html

  def new
    @discussion  = Discussion.new()
  end

  def index
    @discussions = Discussion.order('id desc').limit(10).reverse
    respond_to do |format|
      format.html {  }
      format.json { render :json =>  @discussions }
    end
  end

  def show
    @discussion = Discussion.find params[:id]
    respond_to do |format|
      format.html {  }
      format.json { render :json =>  @discussion }
    end
  end

  def edit
    @discussion = Discussion.find params[:id]
  end

  def update
    @discussion = Discussion.find params[:id]
    @discussion.user = current_user
    @discussion.update_attributes(params[:discussion])
    if @discussion.errors.present?
      flash[:errors]  = @discussion.errors.full_messages
    end
    respond_to do |format|
      format.html { redirect_to @discussion  }
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