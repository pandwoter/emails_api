class Recipient < ApplicationRecord
  has_and_belongs_to_many :campaigns, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
