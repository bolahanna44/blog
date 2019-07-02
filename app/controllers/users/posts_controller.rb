class Users::PostsController < Users::ApplicationController
  def index
    @posts = load_posts
  end

  def show
    @post = load_post
    authorize @post
  end

  private

  def load_post
    Post.find(params[:id])
  end

  def load_posts
    Post.all.published.order(created_at: :desc).includes(:user).page(params[:page]).per(8)
  end
end


