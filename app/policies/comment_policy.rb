class CommentPolicy < ApplicationPolicy

    def create?
        user
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
        update?
    end

end