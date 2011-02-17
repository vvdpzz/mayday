class RechargeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @records = current_user.records
  end
  
  def new
  end
  
  def create
    user = current_user
    amount = params[:amount].to_i
    order = user.records.build(
      :iotype => true,
      :amount => amount,
      :payee => user.class.to_s,
      :payee_id => user.id,
      :payer => user.class.to_s,
      :payer_id => user.id,
      :caption => 'recharge',
      :remark => "recharge #{amount}",
      :status => 'pending'
    )
    if order.save
      redirect_to(recharge_url(:id => order.id), :notice => 'Order created successfully!')
    else
      render :new
    end
  end
  
  def show
    @order = current_user.records.find params[:id]
  end
  
  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    # AlipayTxn.create(:notify_id => notification.notify_id, 
    #                      :total_fee => notification.total_fee, 
    #                      :status => notification.trade_status, 
    #                      :trade_no => notification.trade_no, 
    #                      :received_at => notification.notify_time)

    notification.acknowledge
    
    @order = current_user.records.find notification.out_trade_no
    if notification.trade_status == "TRADE_SUCCESS" and @order.status == "pending"
      @order.update_attribute(:status,"success")
      @order.user.update_attribute(:money, @order.user.money + notification.total_fee*100.to_i)
    end
  end
  
  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)  
    unless @result = r.success?
      logger.warn(r.message)
    end  
  end
end
