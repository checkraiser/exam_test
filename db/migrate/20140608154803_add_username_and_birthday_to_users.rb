class AddUsernameAndBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :birthday, :string
  end
end
