class AccessPolicy
  include AccessGranted::Policy

  def configure
    # Example policy for AccessGranted.
    # For more details check the README at
    #
    # https://github.com/chaps-io/access-granted/blob/master/README.md
    #
    # Roles inherit from less important roles, so:
    # - :admin has permissions defined in :member, :guest and himself
    # - :member has permissions from :guest and himself
    # - :guest has only its own permissions since it's the first role.
    #
    # The most important role should be at the top.
    # In this case an administrator.
    #
    role :admin, { is_admin: true } do
      can [:create, :update, :destroy], Subscriber
      can [:create, :update, :destroy], Book
      can [:create, :update, :destroy, :change_user_type], User
      can :upload_data
      can :add_book
      can :view_menu
    end

    # More privileged role, applies to registered users.
    #
    role :clerk, proc { |user| user.clerk? } do
      can [:view, :create, :update], Subscriber
      can :view, Book
    end

    # The base role with no additional conditions.
    # Applies to every user.
    #
    role :guest do
      can [:view, :update], User do |user_record, current_user|
        user_record.id == current_user.id
      end
    end
  end
end
