class AnswerObserver < ActiveRecord::Observer

  def after_create(answer)
    Notification.deliver(answer.question.user, answer.user, "answered", answer.question)
  end

end