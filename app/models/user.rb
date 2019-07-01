class User < ApplicationRecord
  has_many :posts

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook google_oauth2]

  validates :username, presence: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
    end
  end
end
