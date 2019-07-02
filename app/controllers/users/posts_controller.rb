class Users::PostsController < Users::ApplicationController
  def index
    @posts = load_posts
  end

  def show
    @post = load_post
  end

  private

  def load_post
    Post.published.find(params[:id])
  end

  def load_posts
    Post.all.published.order(created_at: :desc).includes(:user).page(params[:page]).per(8)
  end
end


