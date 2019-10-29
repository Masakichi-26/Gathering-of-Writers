module GroupsHelper

    def is_creator?(group)
        group.creator == current_user
    end


end
