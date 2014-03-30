class CreateAssignmentConfigs < ActiveRecord::Migration
  def change
    create_table :assignment_configs do |t|
      t.integer :assignment_id
      t.text :input
      t.text :output

      t.timestamps
    end
  end
end
