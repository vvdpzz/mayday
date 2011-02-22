class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name, :case_sensitive => false, :message => "must be unique"
  
  include SentientUser
  
  include Gravtastic
  gravtastic
  
  acts_as_taggable
  
  has_many :questions
  has_many :answers
  has_many :records
  has_many :notifications
  has_many :brainstorms
  
  after_create :register_gift
  
  def afford_to_pay_ask?
    self.money >= APP_CONFIG['ask_charge'].to_i ? true : false
  end
  
  def name_and_headline
    [self.name, self.headline].compact.join(',').to_s
  end
  
  def register_gift
    system = User.find_by_name('greedy')
    amount = APP_CONFIG['register_gift'].to_i
    system.update_attribute(:money, system.money - amount)
    self.update_attribute(:money, amount)
    Record.accounting(self, true,    amount, self, system, 'register_gift', 'register gift', 'success')
    Record.accounting(system, false, amount, self, system, 'register_gift', 'register gift', 'success')
  end
  
end
