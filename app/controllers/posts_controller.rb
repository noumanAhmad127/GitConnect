class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_profile, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @posts = params[:tag] ? Post.tagged_with(params[:tag]) : Post.all
  end

  def show; end

  def new
    @post = @profile.posts.new
  end

  def create
    @post = @profile.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end


  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end

  def authorize_user!
    return if @post.profile == current_user.profile

    redirect_to posts_path, alert: 'You are not authorized to perform this action.'
  end
end
