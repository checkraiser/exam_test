class AddOutputToAssignmentResults < ActiveRecord::Migration
  def change
    add_column :assignment_results, :output, :text
  end
end
