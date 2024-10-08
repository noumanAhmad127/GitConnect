class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    puts 'Like action triggered'
    puts params.inspect

    @like = current_user.profile.likes.build(like_params)
    puts @like.inspect

    if @like.save
      redirect_back(fallback_location: root_path, notice: 'Post liked!')
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    puts 'Like destroy triggered'
    @like = current_user.profile.likes.find_by(id: params[:id])
    puts @like.inspect

    if @like.present?
      @like.destroy
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Couldn't find the like to delete."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type, :profile_id)
  end
end
