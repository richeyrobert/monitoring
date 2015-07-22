class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.references :backup, index: true, foreign_key: true
      t.string :configfile

      t.timestamps null: false
    end
  end
end
