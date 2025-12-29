class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.integer :status
      t.text :error_message

      t.timestamps
    end
  end
end
