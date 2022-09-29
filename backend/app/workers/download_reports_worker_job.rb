class DownloadReportsWorkerJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(*args)
    Services::Reports::DownloadReports.new.call
  end
end
