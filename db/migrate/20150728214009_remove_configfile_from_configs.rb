class RemoveConfigfileFromConfigs < ActiveRecord::Migration
  def change
    remove_column :configs, :configfile, :string
  end
end
