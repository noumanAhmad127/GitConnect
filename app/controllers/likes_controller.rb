class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable

  def create
    byebug
    @like = @likeable.likes.create(profile: current_user.profile)

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path } # Use fallback_location as a safety
      format.js do
        render json: { id: @likeable.id, html: render_to_string(partial: 'likes/like_button', locals: { post: @likeable }),
                       like_count: @likeable.likes.count }
      end
    end
  end

  def destroy
    @likeable.likes.find_by(profile: current_user.profile)&.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  private

  def find_likeable
    @likeable = Post.find(params[:post_id]) if params[:post_id]
  end
end
