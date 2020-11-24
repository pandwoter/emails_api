class ApplicationController < ActionController::API
  include Dry::Monads[:result]

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {
      error: { type: :not_found, error_text: e.to_s }
    }, status: :not_found
  end
end
