class CreateDevtypes < ActiveRecord::Migration
  def change
    create_table :devtypes do |t|
      t.string :name
      t.string :manufacturer
      t.string :model
      t.text :notes
      t.boolean :active
      t.timestamp :archived_at

      t.timestamps null: false
    end
  end
end
