class ParseSegmentsWorkerJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(*args)
    Services::Segments::ParseSegments.new.call
  end
end
