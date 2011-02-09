class QuestionsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  before_filter :find_my_question, :only => [:edit, :update, :destroy, :accept]

  def index
    @questions = Question.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @questions }
    end
  end

  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @question }
    end
  end

  def new
    @question = current_user.questions.build

    respond_to do |format|
      if current_user.afford_to_pay_ask?
        format.html
        format.xml  { render :xml => @question }
      else
        format.html { redirect_to(questions_url, :notice => 'You do not have enough money to pay ask charge. Please recharge.') }
      end
    end
  end

  def edit
  end

  def create
    @question = current_user.questions.build(params[:question])
    
    @question.rendering

    respond_to do |format|
      if @question.save
        @question.add_tags_to_user
        @question.charge
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    
    offset = params[:question][:reward].to_i - @question.reward
    
    @question.body = params[:question][:body]
    @question.more = params[:question][:more]
    @question.reward = params[:question][:reward]
    @question.anonymous = params[:question][:anonymous]
    @question.rendering
    
    respond_to do |format|
      if @question.save
        @question.add_tags_to_user
        @question.charge(reward = offset) if offset > 0
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
  
  def tagged
    @questions = Question.tagged_with(params[:tag])
  end
  
  def accept
    answer = Answer.find params[:answer_id]
    @question.accepted_answer_id = params[:answer_id]
    @question.status = "accepted"
    if @question.save
      answer.user.update_attribute(:money, answer.user.money + @question.amount_sum)
      @question.accounting_accepted(answer.user.id)
      records = @question.user.records.where(:caption => "reward", :status => "pending", :payee_id => @question.id)
      records.each do |record|
        record.update_attribute(:status, "success") if record.status == "pending"
      end
      redirect_to @question
    end
  end
  
  protected
    def find_my_question
      @question = current_user.questions.find(params[:id])
    end
  
end
