class AbstractWorker
  include Sidekiq::Worker
  include Dry::Monads[:result]

  def perform
    raise NotImplementedError, 'You schould implement this in particular provider class'
  end
end
