class AddDevtypeToDevices < ActiveRecord::Migration
  def change
    add_reference :devices, :devtype, index: true, foreign_key: true
  end
end
