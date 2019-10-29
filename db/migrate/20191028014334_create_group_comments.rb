class CreateGroupComments < ActiveRecord::Migration[5.1]
  def change
    create_table :group_comments do |t|
      t.references :user
      t.references :group_article
      t.text :content
      t.timestamps
    end
  end
end
