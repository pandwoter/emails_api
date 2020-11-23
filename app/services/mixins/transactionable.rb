module Mixins
  module Transactionable
    def with_transaction(&block)
      ActiveRecord::Base.transaction do
        block.call
      end
    end
  end
end
