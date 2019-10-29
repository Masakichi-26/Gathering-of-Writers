class GroupArticle < ApplicationRecord
    validates :title, :content, presence: true
    has_many :group_comments, dependent: :destroy
    belongs_to :user
    belongs_to :group, foreign_key: :group_id
end
