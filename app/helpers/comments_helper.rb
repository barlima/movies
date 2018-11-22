module CommentsHelper
  def comment_author(comment)
    comment.user.name ? comment.user.name : "Unknown"
  end

  def sort_comments(comments)
    comments.order("created_at DESC")
  end
end