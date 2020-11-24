module Pagination
  class PaginationService < BaseService
    include Pagy::Backend

    attr_reader :model, :params

    def initialize(model, params)
      @model = model
      @params = params
    end

    def call
      _, records = pagy(model)

      records
    end
  end
end
