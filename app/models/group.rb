class Group < ApplicationRecord
    validates :name, :description, :item_name, :creator, presence: true
    validates :name, uniqueness: {:scope => :creator }
    has_and_belongs_to_many :users, :join_table => :users_groups, dependent: :destroy
    belongs_to :creator, class_name: 'User', foreign_key: :user_id
    has_many :group_articles, dependent: :destroy
    has_many :group_comments
end
