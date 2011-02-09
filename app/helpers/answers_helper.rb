module AnswersHelper
  
  def add_commentable_to(answer)
    if user_signed_in?
      return link_to('Add comment', new_answer_comment_url(:answer_id => answer.id), :remote => true)
    else
      return nil
    end
  end
  
  def editable_by(answer)
    if answer.editable_by?(current_user)
      return link_to('Edit', [:edit, answer.question,answer])
    else
      return nil
    end
  end
  
  def links(answer)
    [add_commentable_to(answer), editable_by(answer), timestamp(answer)].compact.join(delimitor).to_s.html_safe
  end
  
end
