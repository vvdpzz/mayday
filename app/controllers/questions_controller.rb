class QuestionsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  before_filter :find_my_question, :only => [:edit, :update, :destroy]

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
      puts "okokokokokokokokokokokoko"
      
      if @question.save
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @question.body = params[:question][:body]
    @question.more = params[:question][:more]
    @question.reward = params[:question][:reward]
    respond_to do |format|
      if @question.save
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
  
  protected
    def find_my_question
      @question = current_user.questions.find(params[:id])
    end
  
end
