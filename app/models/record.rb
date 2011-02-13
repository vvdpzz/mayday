class Record < ActiveRecord::Base
  belongs_to :user
  
  def self.accounting(user, iotype, amount, payee, payer, caption, remark, status)
    user.records.create(
      :iotype => iotype,
      :amount => amount,
      :payee => payee.class.to_s,
      :payee_id => payee.id,
      :payer => payer.class.to_s,
      :payer_id => payer.id,
      :caption => caption,
      :remark => Helper.truncate(remark),
      :status => status
    )
  end
  
end
