class AddDescriptionToBackups < ActiveRecord::Migration
  def change
    add_column :backups, :description, :string
    add_column :backups, :notes, :text
  end
end
