module GroupsHelper

    def is_creator?(group)
        group.creator == current_user
    end

    def current_group

    end

end
