class GroupComment < ApplicationRecord
    validates :content, :user, :group_article, presence: true
    belongs_to :group_article, foreign_key: :group_article_id
    belongs_to :user, foreign_key: :user_id
end