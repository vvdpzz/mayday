module QuestionsHelper
  
  def add_commentable_to_question(question)
    if user_signed_in?
      return link_to('Add comment', new_question_comment_url(:question_id => question.id), :remote => true)
    else
      return nil
    end
  end
  
  def editable_by_question(question)
    if question.editable_by?(current_user)
      return link_to('Edit', [:edit, question])
    else
      return nil
    end
  end
  
  def links_for_question(question)
    [add_commentable_to_question(question), editable_by_question(question), timestamp(question)].compact.join(delimitor).to_s.html_safe
  end
  
  def history_max(question)
    content_tag(:span, pluralize(@question.history_max, "cent").html_safe, :class => 'history_max')
  end
  
  def question_status(question)
    [tags(question), history_max(question)].compact.join(delimitor).to_s.html_safe
  end
  
end
