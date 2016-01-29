class ChangeCommunityToBlobOnRouters < ActiveRecord::Migration
  def up
    change_column :routers, :community, :binary
  end
  def down
    change_column :routers, :community, :text
  end
end
