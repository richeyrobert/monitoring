class AddCredentialsToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :config_user, :string
    add_column :devices, :config_pass, :string
  end
end
