class CreateGroupArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :group_articles do |t|
      t.string :title
      t.text :content
      t.references :user
      t.timestamps
    end
  end
end
