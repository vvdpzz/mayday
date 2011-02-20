class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  
  validates_presence_of :body, :message => "can't be blank"
  validates_length_of :body, :minimum => 5
  validates_length_of :body, :maximum => 140
end
