class CreateRouters < ActiveRecord::Migration
  def change
    create_table :routers do |t|
      t.string :name
      t.string :ip_address
      t.string :model
      t.text :connection_info

      t.timestamps null: false
    end
  end
end
