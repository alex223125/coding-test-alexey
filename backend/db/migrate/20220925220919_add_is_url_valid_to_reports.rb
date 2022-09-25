class AddIsUrlValidToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :is_url_valid, :boolean, default: nil
  end
end
