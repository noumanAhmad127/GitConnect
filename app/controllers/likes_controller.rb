class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @likeable.likes.create(profile: current_user.profile)
    redirect_back fallback_location: root_path
  end

  def destroy
    @likeable.likes.find_by(profile: current_user.profile)&.destroy
    redirect_back fallback_location: root_path
  end

  private

  def find_likeable
    @likeable = Post.find(params[:post_id]) if params[:post_id].present?
  end
end
