class Comment < ApplicationRecord
    validates :content, :article_id, presence: true
    belongs_to :article
    belongs_to :user
end
