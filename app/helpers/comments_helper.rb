module CommentsHelper
  def count_comments(comment)
    total_comments = 1
    comment.comments.each do |nested_comment|
      total_comments += count_comments(nested_comment)
    end
    total_comments
  end

  # Method to count all comments for a post (top-level + nested)
  def total_comment_count(post)
    post.comments.sum { |comment| count_comments(comment) }
  end
end
