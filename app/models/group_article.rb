class GroupArticle < ApplicationRecord
    validates :title, :content, presence: true
    validates :title, uniqueness: {:scope => :group_id }
    has_many :group_comments, dependent: :destroy
    belongs_to :user
    belongs_to :group, foreign_key: :group_id
end
