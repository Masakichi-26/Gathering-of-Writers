class GroupPolicy < ApplicationPolicy

    def index?
        user
    end

    def new?
        create?
    end

    def create?
        user
    end

    def show?
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

    def edit?
        update?
    end

    def update?
        record.creator == user
    end

end