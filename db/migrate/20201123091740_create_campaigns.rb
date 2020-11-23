class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.string :message
      t.string :subject
      t.index  :subject

      t.timestamps
    end
  end
end
