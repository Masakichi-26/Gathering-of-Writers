class UserPolicy < ApplicationPolicy

    def new?
        true
    end

    def create?
        true
    end

    def edit?
        update?
    end

    def update?
        record == user
    end

    def destroy?
        update?
    end

    def show?
        true
    end

    def search?
        user
    end

    def confirm_email?
        user
    end

    def change_password?
        record == user
    end

    def change_password_confirm?
        record == user
    end






end