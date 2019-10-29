class AddGroupIdToGroupArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :group_articles, :group_id, :integer
  end
end
