class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  acts_as_commentable
  
  validates_presence_of :body, :message => "can't be blank"
  validates_length_of :body, :minimum => 15
  
  validate :afford_to_pay_answer, :on => :create
  
  def editable_by?(user)
    user && (self.user == user)
  end
  
  def rendering
    body_markdown = BlueCloth.new(self.body).to_html
    self.body_markdown = body_markdown
    self.excerpt = Helper.truncate(body_markdown.gsub(/<\/?[^>]*>/,  ''), :length => 140)
  end
  
  def charge
    increase_cost
    self.question.deduction(self.user, 0, 0, APP_CONFIG['answer_charge'].to_i)
    accounting_answer
  end
  
  def increase_cost
    question = self.question
    question.update_attribute(:cost, question.cost + APP_CONFIG['answer_charge'].to_i)
  end
  
  def accounting_answer
    Record.accounting(self.user, false, APP_CONFIG['answer_charge'].to_i, self.question, self.user, 'answer', self.excerpt, 'success')
  end
  
  def afford_to_pay_answer
    errors.add_to_base("You do not have enough money to pay, please recharge.") if self.user.money < APP_CONFIG['answer_charge'].to_i
  end

end
