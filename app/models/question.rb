class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, :dependent => :destroy
    
  acts_as_taggable

  validates_presence_of :body, :message => "can't be blank"
  validates_length_of :body, :minimum => 15
  validates_length_of :body, :maximum => 140

  validates_numericality_of :reward, :message => "is not a number"

  validate :afford_to_pay_ask, :on => :create
  validate :afford_to_pay_reward, :on => :create
  
  validate :could_modify_reward, :on => :update

  def rendering
    body_markdown = BlueCloth.new(self.body).to_html
    more_markdown = BlueCloth.new(self.more).to_html
    self.body_markdown = body_markdown
    self.more_markdown  = more_markdown
    self.excerpt = truncate(body_markdown.gsub(/<\/?[^>]*>/,  ''), :length => 140)
  end
  
  def add_tags_to_user(user = self.user)
    user.tag_list.add(self.tag_list)
    user.save
  end

  def calc_amount_sum_and_update_history_max
    new_amount_sum = self.cost + self.reward
    if self.amount_sum != new_amount_sum
      self.update_attribute(:amount_sum, new_amount_sum)
      self.update_attribute(:history_max, new_amount_sum) if new_amount_sum > self.history_max
    end
  end

  def afford_to_pay_ask
    errors.add_to_base("you do not have enough money to pay ask charge, please recharge.") if self.user.money < APP_CONFIG['ask_charge'].to_i
  end

  def afford_to_pay_reward
    errors.add(:reward, "you do not have enough money to pay, please recharge.") if self.user.money < self.reward
  end
  
  def could_modify_reward
    question = Question.find_by_id(self.id)
    offset = self.reward - question.reward
    if offset >= 0
      if self.user.money < offset
        errors.add(:reward, "you do not have enough money to pay, please recharge.")
      end
    else
      errors.add(:reward, "you can't decrease the reward. please undo modification.")
    end
  end
  
  def truncate(text, options = {})
    options.reverse_merge!(:length => 30)
    text.truncate(options.delete(:length), options) if text
  end

end
