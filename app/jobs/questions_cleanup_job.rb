class QuestionsCleanupJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Rails.logger.error "Hello World"
  end
end
