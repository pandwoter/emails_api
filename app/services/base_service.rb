require 'dry/monads'
require 'dry/monads/do'

class BaseService
  include Dry::Monads[:list]
  include Dry::Monads[:result]

  def call
    raise NotImplementedError, 'You schould implement this in particular provider class'
  end
end
