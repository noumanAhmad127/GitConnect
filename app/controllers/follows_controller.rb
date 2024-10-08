class FollowsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_profile

  def create
    @follow = current_user.profile.follower_relationships.build(followed_id: @profile.id)

    if @follow.save
      redirect_to profile_path(@profile), notice: 'You are now following this developer.'
    else
      redirect_to profile_path(@profile), alert: 'Unable to follow this developer.'
    end
  end

  def destroy
    @follow = current_user.profile.follower_relationships.find_by(followed_id: @profile.id)

    if @follow
      @follow.destroy
      redirect_to profile_path(@profile), notice: 'You are no longer following this developer.'
    else
      redirect_to profile_path(@profile), alert: 'Unable to unfollow this developer.'
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
