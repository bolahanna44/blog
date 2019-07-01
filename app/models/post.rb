class Post < ApplicationRecord
  include AASM

  belongs_to :user

  validates :title, presence: true, length: { maximum: 240 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :content, presence: true, length: { maximum: 2000 }

  aasm column: 'state' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end
  end
end
