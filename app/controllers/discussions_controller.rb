class DiscussionsController < ApplicationController
  respond_to :json, :html, :partial

  def new
    @discussion  = Discussion.new()
    respond_to do |format|
      format.html {}
      format.partial{ }
    end
  end

  def index
    @discussions = Discussion.order('id desc').limit(10).reverse
    respond_to do |format|
      format.html {  }
      format.json {
        render :json =>  @discussions
      }
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
    respond_to do |format|
      format.html {}
      format.partial{ render "edit.html", :layout => false }
    end
  end

  def update
    @discussion = Discussion.find params[:id]
    head :unauthorized and return unless @discussion.user == current_user

    @discussion.update_attributes(params[:discussion])
    if @discussion.errors.present?
      flash[:errors]  = @discussion.errors.full_messages
    end
    respond_to do |format|
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