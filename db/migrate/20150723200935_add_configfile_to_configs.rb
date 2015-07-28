class AddConfigfileToConfigs < ActiveRecord::Migration
  def change
    add_column :configs, :configfile, :string
  end
end
