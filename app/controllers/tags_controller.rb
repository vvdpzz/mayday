class TagsController < ApplicationController

  def index
    @tags = Tag.all.paginate :page => params[:page]
  end

end
