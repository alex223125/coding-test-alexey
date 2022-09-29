class AddErrorReasonToSegments < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :error_reason, :string
  end
end
