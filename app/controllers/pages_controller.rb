class PagesController < ApplicationController
  def index
    if signed_in?
      @feed = current_user.posts
      @post = Post.new
    end
  end

  def about
  end

  def contact
  end
end
