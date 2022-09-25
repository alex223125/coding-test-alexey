class AddErrorReasonToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :error_reason, :text
  end
end
