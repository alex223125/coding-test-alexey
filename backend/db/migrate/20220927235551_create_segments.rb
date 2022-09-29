class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.text :content
      t.text :category

      t.timestamps
    end
  end
end
