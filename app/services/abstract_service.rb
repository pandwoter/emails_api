class AbstractService
  include Dry::Monads[:list]
  include Dry::Monads[:result]

  def call
    raise NotImplementedError, 'You schould implement call!'
  end
end
