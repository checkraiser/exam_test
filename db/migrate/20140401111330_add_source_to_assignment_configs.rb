class AddSourceToAssignmentConfigs < ActiveRecord::Migration
  def change
    add_column :assignment_configs, :source, :text
  end
end
