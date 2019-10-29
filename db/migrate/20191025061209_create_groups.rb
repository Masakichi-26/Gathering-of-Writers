class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.integer :user_id # the id of the person who created the group
      t.string :item_name
      t.timestamps
    end
  end
end
