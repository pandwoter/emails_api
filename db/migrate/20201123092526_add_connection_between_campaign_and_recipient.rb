class AddConnectionBetweenCampaignAndRecipient < ActiveRecord::Migration[6.0]
  def change
    add_reference :campaigns, :recipient, foreign_key: true
  end
end
