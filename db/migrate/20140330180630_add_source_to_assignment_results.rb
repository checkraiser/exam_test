class AddSourceToAssignmentResults < ActiveRecord::Migration
  def change
    add_column :assignment_results, :source, :text
  end
end
