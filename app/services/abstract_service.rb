class AbstractService
  include Dry::Monads[:list]
  include Dry::Monads[:result]

  def call
    raise NotImplementedError, 'You schould implement this in particular provider class'
  end
end
