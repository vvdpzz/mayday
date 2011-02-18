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
    render :text => "fail" unless notification.acknowledge
    
    @order = Record.find notification.out_trade_no
    if notification.complete? and @order.status == "pending"
      @order.update_attribute(:status,"success")
      @order.user.update_attribute(:money, @order.user.money + notification.total_fee*100.to_i)
      render :text => "success"
    end
  end
  
  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    @order = Record.find r.order
    render :action => :show
  end
end
