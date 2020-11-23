class Campaign < ApplicationRecord
  has_and_belongs_to_many :recipients, dependent: :destroy

  enum delivery_state: { pending: 'pending', delivered: 'delivered', failed: 'failed' }

  validates :delivery_state, inclusion: { in: delivery_states.keys }
end
