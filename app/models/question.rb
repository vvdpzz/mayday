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
  
  def charge(reward = self.reward)
    deduction(self.user, APP_CONFIG['ask_charge'].to_i, reward, 0)
    accounting_ask
    accounting_reward reward
  end
  
  def deduction(user, ask, reward, answer)
    sum = ask + reward + answer
    user.update_attribute(:money, user.money - sum)
    calc_amount_sum_and_update_history_max
  end
  
  def accounting(user, iotype, amount, payee, payer, caption, remark, status)
    user.records.create(
      :iotype => iotype,
      :amount => amount,
      :payee => payee.class.to_s,
      :payee_id => payee.id,
      :payer => payer.class.to_s,
      :payer_id => payer.id,
      :caption => caption,
      :remark => truncate(remark),
      :status => status
    )
  end
  
  def accounting_ask
    accounting(self.user, false, APP_CONFIG['ask_charge'].to_i, User.first, self.user, 'ask', self.excerpt, 'success')
  end
  
  def accounting_reward(reward)
    accounting(self.user, false, reward, self, self.user, 'reward', self.excerpt, 'pending') if self.reward > 0
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
