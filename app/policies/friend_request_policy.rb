class FriendRequestPolicy < ApplicationPolicy

    def index?
        update?
    end

    def create?
        update?
    end

    def update?
        user
    end

    def destroy?
        update?
    end


end