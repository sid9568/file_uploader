class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate(auth_options)

    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash[:alert] = "User not found"
      redirect_to new_session_path(resource_name)
    end
  end
end
