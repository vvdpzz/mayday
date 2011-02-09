class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :who_called_comment

  def new
  end

  def create
    @comment = @instance.comments.create(:user_id => current_user.id, :body => params[:comment][:body])
  end

  protected
    def who_called_comment
      if params[:question_id]
        commentable = "question"
        id = params[:question_id]
      end
      if params[:answer_id]
        commentable = "answer"
        id = params[:answer_id]
      end
      particular_model = commentable.classify.constantize
      @instance = particular_model.find id
    end
end
