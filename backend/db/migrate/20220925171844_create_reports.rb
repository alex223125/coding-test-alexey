class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :link
      t.boolean :is_downloaded, default: false
      t.boolean :is_processed, default: false
      t.string :source
      t.string :version

      t.timestamps
    end
  end
end
