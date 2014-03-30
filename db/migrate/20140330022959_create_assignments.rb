class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.string :title
      t.text :content
      t.text :description

      t.timestamps
    end
  end
end
