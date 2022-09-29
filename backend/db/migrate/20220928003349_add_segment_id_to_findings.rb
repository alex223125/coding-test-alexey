class AddSegmentIdToFindings < ActiveRecord::Migration[6.1]
  def change
    add_column :findings, :segment_id, :integer
  end
end
