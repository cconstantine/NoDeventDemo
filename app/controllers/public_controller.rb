class PublicController < ApplicationController

  def show
    @discussions = Discussion.order('id desc').limit(10).reverse
    @new_discussion = Discussion.new
  end
end
