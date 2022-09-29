# frozen_string_literal: true

class ParseSegmentsWorkerJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(*_args)
    Services::Segments::ParseSegments.new.call
  end
end
