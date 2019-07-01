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

  def update
    post = load_post

    if post.update(post_params)
      render json: post
    else
      render json: { error: post.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      redirect_to publish_post_path(post)
    else
      flash.now.alert = post.errors.full_messages.to_sentence
      render :new
    end
  end

  def publish
    @post = load_post
  end

  private

  def load_post
    Post.find(params[:id])
  end

  def load_posts
    Post.all.order(created_at: :desc).includes(:user).page(params[:page]).per(8)
  end

  def post_params
    params.require(:post).permit(:title, :description, :content, :state, :publish_date)
  end
end
