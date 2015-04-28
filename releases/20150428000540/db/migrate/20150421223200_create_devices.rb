class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :description
      t.string :ip_address
      t.boolean :device_status
      t.boolean :ipv6
      t.integer :snmp_template

      t.timestamps null: false
    end
  end
end
