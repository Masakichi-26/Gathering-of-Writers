class FriendshipPolicy < ApplicationPolicy

    def index?
        user
    end

    def destroy?
        user
    end

end