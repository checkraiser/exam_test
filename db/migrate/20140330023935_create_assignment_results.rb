class CreateAssignmentResults < ActiveRecord::Migration
  def change
    create_table :assignment_results do |t|
      t.integer :enrollment_id
      t.integer :assignment_id
      t.boolean :pass

      t.timestamps
    end
  end
end
