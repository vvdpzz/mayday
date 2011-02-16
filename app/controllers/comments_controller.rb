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
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @instance = $1.classify.constantize.find(value)
      end
    end
  end
end
