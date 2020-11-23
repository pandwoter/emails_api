class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :subject, :message, :delivery_state

  has_many :recipients
end
