class RemoveKeyFromRouters < ActiveRecord::Migration
  def change
    remove_column :routers, :key
    remove_column :routers, :iv
  end
end
