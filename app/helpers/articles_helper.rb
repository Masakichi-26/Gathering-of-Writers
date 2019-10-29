module ArticlesHelper

    def can_edit_delete?(user)
        logged_in? && current_user == user
    end
end
