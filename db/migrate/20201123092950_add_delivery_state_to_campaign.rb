class AddDeliveryStateToCampaign < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE campaign_delivery_state AS ENUM ('pending', 'delivered', 'failed');
    SQL
    add_column :campaigns, :delivery_state, :campaign_delivery_state
  end
  def down
    remove_column :campaigns, :delivery_state
    execute <<-SQL
      DROP TYPE campaign_delivery_state;
    SQL
  end
end
