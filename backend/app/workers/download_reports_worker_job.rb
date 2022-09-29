# frozen_string_literal: true

class DownloadReportsWorkerJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(*_args)
    Services::Reports::DownloadReports.new.call
  end
end
