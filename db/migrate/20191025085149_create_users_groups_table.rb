class CreateUsersGroupsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users_groups, id: false do |t|
      t.belongs_to :user
      t.belongs_to :group

      t.timestamps
    end
  end
end
