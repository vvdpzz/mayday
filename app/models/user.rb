class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name, :case_sensitive => false, :message => "must be unique"
  
  include Gravtastic
  gravtastic
  
  acts_as_taggable
  
  has_many :questions
  has_many :answers
  
  def afford_to_pay_ask?
    self.money >= APP_CONFIG['ask_charge'].to_i ? true : false
  end
  
  def name_and_headline
    comma = ', ' if self.headline.present?
    "#{self.name}#{comma}#{self.headline}"
  end
  
end