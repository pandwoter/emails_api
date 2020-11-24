module Recipients
  class RecipientCreationService < BaseService
    attr_reader :email

    def initialize(email)
      @email = email
    end

    def call
      recipient = Recipient.find_or_create_by!(payload)

      Success(recipient)
    rescue ActiveRecord::RecordInvalid => e
      Failure(e.record.errors.to_h)
    end

    private

    def payload
      {
        email: email
      }
    end
  end
end
