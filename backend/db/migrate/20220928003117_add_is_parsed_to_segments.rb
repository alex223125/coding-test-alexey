class AddIsParsedToSegments < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :is_parsed, :boolean, default: false
  end
end
