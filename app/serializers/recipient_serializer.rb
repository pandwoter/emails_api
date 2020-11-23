class RecipientSerializer < ActiveModel::Serializer
  attributes :id, :email, :campaigns_count, :campaigns_info

  def campaigns_count
    object.campaigns.size
  end

  def campaigns_info
    object.campaigns.map do |c|
      {
        subject: c.subject,
        message: c.message,
        delivery_status: c.delivery_state
      }
    end
  end
end
