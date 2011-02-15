class NotificationObserver < ActiveRecord::Observer
  observe :answer, :comment
  
  def after_create(answer)
    Notification.deliver(answer.question.user, answer.user, "answered", answer.question)
  end
  
  def after_create(comment)
    commentable_str, commentable_id = comment.commentable_type, comment.commentable_id
    obj = commentable_str.constantize.find(commentable_id)
    Notification.deliver(obj.user, comment.user, "replied", obj)
  end
end