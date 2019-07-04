class User::PostsController < User::ApplicationController
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
    post = current_user.posts.build(post_params)

    if post.save && post.create_otp(auth_method: params[:auth_method])
      redirect_to user_otp_path(post.otp)
    else
      flash.now.alert = post.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description,
                                 :content,
                                 :publish_date, :photo)
  end

  def load_post
    Post.friendly.find(params[:id])
  end

  def load_posts
    current_user.posts.order(created_at: :desc).includes(:otp)
  end
end
