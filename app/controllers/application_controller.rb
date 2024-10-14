class ApplicationController < ActionController::Base
  before_action :set_cache_buster
  include Pagy::Backend


  def after_sign_in_path_for(resource)
    resource.profile ? profile_path(resource.profile) : new_profile_path
  end


def set_cache_buster
  response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
  response.headers["Pragma"] = "no-cache"
  response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
end

end
