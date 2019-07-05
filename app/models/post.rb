class Post < ApplicationRecord
  include AASM
  extend FriendlyId

  friendly_id :title, use: :slugged

  belongs_to :user
  has_one :otp, as: :verifiable, dependent: :destroy
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 240 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :content, presence: true, length: { maximum: 2000 }

  aasm column: 'state' do
    state :draft, initial: true
    state :published
    state :scheduled

    event :publish do
      transitions from: %i[draft scheduled], to: :published
    end

    event :schedule do
      before do
        PublishPostWorker.perform_at(publish_date, id) if publish_date.present?
      end

      transitions from: :draft, to: :scheduled
    end
  end
end
