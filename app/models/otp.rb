class Otp < ApplicationRecord
  include AASM

  belongs_to :verifiable, polymorphic: true

  enum auth_method: %i[authy_app sms]

  aasm column: 'state' do
    state :pending, initial: true
    state :sent
    state :verified

    event :send_otp do
      before do
        send_token
      end

      transitions from: :pending, to: :sent
    end

    event :verify do
      before do
        verify_token
      end

      transitions from: :sent, to: :verified

      after do
        publish_post if verifiable_type == 'Post'
      end
    end
  end

  private

  def send_token
    self.authy_id = Authentication.send_token(mobile, sms?)
  end

  def verify_token
    Authentication.verify_token(authy_id, token)
  end

  def publish_post
    post = verifiable
    post.publish_date.present? && post.publish_date > Time.now ? post.schedule! : post.publish!
  end
end
