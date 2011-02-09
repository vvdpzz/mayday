module AnswersHelper
  
  def accepted(answer)
    if answer.question.status != "accepted"
      return link_to('Set as Correct', accept_url(:id => answer.question.id, :answer_id => answer.id))
    else
      return nil
    end
  end
  
  def add_commentable_to_answer(answer)
    if user_signed_in?
      return link_to('Add comment', new_answer_comment_url(:answer_id => answer.id), :remote => true)
    else
      return nil
    end
  end
  
  def editable_by_answer(answer)
    if answer.editable_by?(current_user)
      return link_to('Edit', [:edit, answer.question,answer])
    else
      return nil
    end
  end
  
  def links(answer)
    [accepted(answer), add_commentable_to_answer(answer), editable_by_answer(answer), timestamp(answer)].compact.join(delimitor).to_s.html_safe
  end
  
end
