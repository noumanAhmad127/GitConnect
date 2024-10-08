class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @likeable = find_likeable
    @likeable.likes.create(profile: current_user.profile)

    redirect_back fallback_location: root_path
  end

  def destroy
    @likeable = find_likeable
    @likeable.likes.find_by(profile: current_user.profile)&.destroy

    redirect_back fallback_location: root_path
  end

  private

  def find_likeable
    params[:post_id] ? Post.find(params[:post_id]) : Comment.find(params[:comment_id])
  end
end
