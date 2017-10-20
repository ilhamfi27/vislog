class Users::InvitationsController < Devise::InvitationsController
  def new
  	super
  end
  
  def create
		super
  end
  
  def edit
		super
  end

  def update
    super
  end
  
  private
    # this is called when creating invitation
    # should return an instance of resource class
    def invite_resource
      ## skip sending emails on invite
      super do |u|
        u.skip_invitation = true
        u.password = "123456"
        u.password_confirmation = "123456"
        u.confirmed_at = Time.now
      end
    end

    # this is called when accepting invitation
    # should return an instance of resource class
    def accept_resource
      resource = resource_class.accept_invitation!(update_resource_params)
      ## Report accepting invitation to analytics
      Analytics.report('invite.accept', resource.id)
      resource
    end
end