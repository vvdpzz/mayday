class BrainstormsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_my_brainstorms, :only => [:show, :edit, :update, :destroy]
  
  def index
    @brainstorm = current_user.brainstorms.build
    @brainstorms = current_user.brainstorms.all
  end

  def show
  end

  def new
    @brainstorm = current_user.brainstorms.build
  end

  def edit
  end

  def create
    @brainstorm = current_user.brainstorms.build(params[:brainstorm])
    @brainstorm.rendering

    if @brainstorm.save
      redirect_to(brainstorms_url, :notice => 'Brainstorm was successfully created.')
    else
      render :new
    end
  end

  def update
    @brainstorm.body = params[:brainstorm][:body]
    @brainstorm.anonymous = params[:brainstorm][:anonymous]
    @brainstorm.rendering
    if @brainstorm.save
      redirect_to(brainstorms_url, :notice => 'Brainstorm was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    @brainstorm.destroy
    redirect_to(brainstorms_url)
  end
  
  protected
    def find_my_brainstorms
      @brainstorm = current_user.brainstorms.find(params[:id])
    end
end
