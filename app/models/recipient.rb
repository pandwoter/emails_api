class Recipient < ApplicationRecord

  has_many :campaigns, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

end
