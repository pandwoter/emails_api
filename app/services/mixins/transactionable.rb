module Mixins
  module Transactionable
    def with_transaction
      ActiveRecord::Base.transaction do
        yield
      end
    end
  end
end
