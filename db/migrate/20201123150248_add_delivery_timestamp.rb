class AddDeliveryTimestamp < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :delivery_date, :datetime
  end
end
