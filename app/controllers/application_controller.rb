class ApplicationController < ActionController::Base
  include SentientController
  protect_from_forgery
end
