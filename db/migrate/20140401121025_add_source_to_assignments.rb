class AddSourceToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :source, :text
  end
end
