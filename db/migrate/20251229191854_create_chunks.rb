class CreateChunks < ActiveRecord::Migration[8.0]
  def change
    create_table :chunks do |t|
      t.references :document, null: false, foreign_key: true
      t.integer :position
      t.text :content

      t.timestamps
    end
  end
end
