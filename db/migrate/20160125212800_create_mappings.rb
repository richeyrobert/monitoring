class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.string :received_text
      t.text :reply_text

      t.timestamps null: false
    end
  end
end
