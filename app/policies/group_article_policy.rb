class GroupArticlePolicy < ApplicationPolicy

    def create?
        user
    end

    def new?
        create?
    end

    def update?
        if !user
            false
        else
            record.user_id == user.id
        end
    end

    def edit?
        update?
    end

    def destroy?
        record.user_id == user.id
    end

    def show?
        if !user
            return false
        else 
            if record.group.users.find_by(id: user.id)
                return true
            else
                return false
            end
        end
    end

end