class CreateConfigs < ActiveRecord::Migration
  def change
    create_table :configs do |t|
      t.references :backup, index: true, foreign_key: true
      t.string :config_file

      t.timestamps null: false
    end
  end
end
