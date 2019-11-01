class ArticlePolicy < ApplicationPolicy

    def index?
        true
    end

    def show?
        true
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
        update?
    end

end