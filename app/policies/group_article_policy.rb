class GroupArticlePolicy < ApplicationPolicy

    # class Scope < Scope
    #     def resolve
    #         scope.where(user_id: user.id)
    #     end
    # end

    def show_group?
        if !user
            return false
        else 
            if record.users.find_by(id: user.id)
                return true
            else
                return false
            end
        end
    end

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

end