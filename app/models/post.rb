class Post < ApplicationRecord
  include AASM

  belongs_to :user

  validates :title, presence: true, length: { maximum: 240 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :content, presence: true, length: { maximum: 2000 }

  after_create_commit :schedule_post_publish

  aasm column: 'state' do
    state :draft, initial: true
    state :published
    state :authenticated

    event :publish do
      transitions from: %i[authenticated draft], to: :published
    end

    event :authenticate do
      transitions from: :draft, to: :authenticated
    end
  end

  private

  def schedule_post_publish
    if publish_date.present?
      PublishPostWorker.perform_at(publish_date, id)
    end
  end
end
