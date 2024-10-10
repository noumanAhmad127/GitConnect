class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_parent_comment, only: [:new, :create]

  def new
    # @comment = @parent_comment.comments.new
    @comment = Comment.new
  end

  def create
    @comment = @parent_comment ? @parent_comment.comments.new(comment_params) : @post.comments.new(comment_params)

    if @comment.save
      redirect_back(fallback_location: post_path(@post), notice: 'Your comment was successfully posted!')
    else
      redirect_back(fallback_location: post_path(@post), alert: "Your comment wasn't posted!")
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_parent_comment
    @parent_comment = Comment.find_by(id: params[:comment_id]) if params[:comment_id]
  end
end
