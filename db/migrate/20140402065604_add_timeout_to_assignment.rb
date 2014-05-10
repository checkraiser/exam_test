class AddTimeoutToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :timeout, :integer
  end
end
