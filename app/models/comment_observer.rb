class CommentObserver < ActiveRecord::Observer
  
  def after_create(comment)
    commentable_str, commentable_id = comment.commentable_type, comment.commentable_id
    obj = commentable_str.constantize.find(commentable_id)
    Notification.deliver(obj.user, comment.user, "replied", obj)
  end
  
end