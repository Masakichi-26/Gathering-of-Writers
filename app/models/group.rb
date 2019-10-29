class Group < ApplicationRecord
    validates :name, :description, :item_name, :creator, presence: true
    has_and_belongs_to_many :users, :join_table => :users_groups
    belongs_to :creator, class_name: 'User', foreign_key: :user_id
    has_many :group_articles
    has_many :group_comments
end
