class AddCommunityToRouters < ActiveRecord::Migration
  def change
    add_column :routers, :community, :string
    add_column :routers, :key, :string
    add_column :routers, :iv, :string
  end
end
