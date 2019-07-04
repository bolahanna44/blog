class User::OtpsController < User::ApplicationController
  def show
    @otp = load_otp
  end

  def send_otp
    otp = load_otp
    otp.mobile = params[:mobile]
    otp.send_otp!
    head :ok
  rescue Authentication::AuthyError => e
    render json: { error: e.message }, status: :bad_request
  end

  def verify
    otp = load_otp
    otp.token = params[:token]
    otp.verify!
    do_action(otp)
    head :ok
  rescue Authentication::AuthyError => e
    render json: { error: e.message }, status: :bad_request
  end



  private

  def do_action(otp)
    publish_post(otp) if otp.verifiable_type == 'Post'
  end

  def publish_post(otp)
    post = otp.verifiable
    post.publish_date.present? && post.publish_date > Time.now ? post.schedule! : post.publish!
  end

  def load_otp
    Otp.find(params[:id])
  end

  def otp_params
    params.require(:otp).permit(:mobile)
  end
end