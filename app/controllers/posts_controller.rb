class PostsController < ApplicationController
  def index
    @posts = load_posts
  end

  def new
    @post = Post.new
  end

  def show
    @post = load_post
  end

  def create
    post = Post.new(user_id: current_user.id)

    if post.update(post_params)
    redirect_to post_path(post)
    else
      flash.now.alert = post.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def load_post
    Post.find(params[:id])
  end

  def load_posts
    Post.all.includes(:user).page(params[:page]).per(8)
  end

  def post_params
    params.require(:post).permit(:title, :description, :content)
  end
end
