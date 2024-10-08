class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    resource.profile ? profile_path(resource.profile) : new_profile_path
  end
end
