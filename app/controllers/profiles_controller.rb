class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_profile, only: %i[show edit update]

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    return unless @profile.nil?

    redirect_to new_profile_path, alert: 'Please create your profile Frist'
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return unless @profile.user != current_user

    redirect_to profile_path(@profile), alert: 'You can only edit your own profile.'
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def followers
    @profile = Profile.find(params[:id])
    @followers = @profile.followers
  end

  def followers
    @profile = Profile.find(params[:id])
    @following = @profile.followed_profiles
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :email, :contact_info, :profile_pic, :headline, :city, :skill_sets,
                                    social_media_links: [], education: %i[degree institution graduation_date], work_experience: %i[company position responsibilities start_date end_date])
  end

  def set_profile
    @profile = Profile.find(params[:id])
    redirect_to new_profile_path, alert: 'Profile not found. Please create a profile.' unless @profile
  end
end
