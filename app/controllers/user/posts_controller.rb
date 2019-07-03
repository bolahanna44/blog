class User::PostsController < User::ApplicationController
  def index
    @posts = load_posts
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      redirect_to publish_user_post_path(post)
    else
      flash.now.alert = post.errors.full_messages.to_sentence
      render :new
    end
  end

  def publish
    @post = load_post
    authorize @post
  end

  def authenticate
    post = load_post
    authorize post
    Authentication.verify_token(params[:authy_id], params[:token])
    post.publish_date.present? && post.publish_date > Time.now ? post.authenticate! : post.publish!
  rescue Authentication::AuthyError => e
    render json: {
        error: e.message
    }, status: :bad_request
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content, :state, :publish_date, :photo)
  end

  def load_post
    Post.find(params[:id])
  end

  def load_posts
    current_user.posts.order(created_at: :desc)
  end
end
