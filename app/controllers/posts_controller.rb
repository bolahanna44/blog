class PostsController < ApplicationController
  def index
    @posts = load_posts
  end

  def show
    @post = load_post
    # following lines work with meta tag gem to add meta tags to the show post page
    @page_description = @post.description
    @page_keywords    = @post.title.split(' ').join(',')
    @page_image_src = @post.photo.attached? && url_for(@post.photo)

  end

  private

  def load_post
    Post.friendly.published.find(params[:id])
  end

  def load_posts
    Post.all.published.order(created_at: :desc).includes(:user)
  end
end


