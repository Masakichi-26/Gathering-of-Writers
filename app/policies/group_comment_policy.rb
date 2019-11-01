class GroupCommentPolicy < ApplicationPolicy

    def create?
        if user 
            @article = GroupArticle.find(record.group_article_id)
            @article.group.users.each do |u|
                if u == user
                    return true
                end
            end
            return false
        else 
            return false
        end
    end

    def edit?
        update?
    end

    def update?
        record.user_id == user.id
    end

    def destroy?
        update?
    end

end