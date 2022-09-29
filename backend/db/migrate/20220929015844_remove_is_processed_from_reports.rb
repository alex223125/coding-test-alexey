class RemoveIsProcessedFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :is_processed
  end
end
