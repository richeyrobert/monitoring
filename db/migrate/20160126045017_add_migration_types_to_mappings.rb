class AddMigrationTypesToMappings < ActiveRecord::Migration
  def change
    add_reference :mappings, :mapping_type, index: true
    add_column :mappings, :function, :text
    add_column :mappings, :hours_url, :string
    add_column :mappings, :location, :text
    add_column :mappings, :call_back_instructions, :text
  end
end
