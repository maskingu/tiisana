class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

private
def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname]) 
devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :profile, %i(avatar)])
end

def after_sign_in_path_for(resource)
  posts_path
end

end
