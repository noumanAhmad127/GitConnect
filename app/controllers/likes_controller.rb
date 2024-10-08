class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.profile.likes.new(like_params)

    if @like.save
      redirect_back(fallback_location: root_path, notice: 'Liked the post!')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to like the post.')
    end
  end

  def destroy
    @like = current_user.profile.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path, notice: 'Unliked the post.')
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
