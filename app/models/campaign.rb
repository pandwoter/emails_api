class Campaign < ApplicationRecord
  belongs_to :recipient
  enum delivery_state: { delivered: 'delivered', failed: 'failed' }

  validates :delivery_state, inclusion: { in: delivery_states.keys }
end
