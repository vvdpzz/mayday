class AnswersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_question
  
  def new
    @answer = current_user.answers.build
    @answer.question_id = @question.id

    respond_to do |format|
      format.html
      format.xml  { render :xml => @answer }
    end
  end

  def edit
    @answer = current_user.answers.find(params[:id])
  end

  def create
    @answer = current_user.answers.build(params[:answer])
    @answer.question_id = @question.id
    
    @answer.rendering

    respond_to do |format|
      if @answer.save
        @answer.question.add_tags_to_user(current_user)
        
        format.html { redirect_to(@question, :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @answer = current_user.answers.find(params[:id])
    @answer.body = params[:answer][:body]
    @answer.anonymous = params[:answer][:anonymous]
    @answer.rendering

    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@question, :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_question
      @question = Question.find params[:question_id]
    end
end
