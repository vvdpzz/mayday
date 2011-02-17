class RechargeController < ApplicationController
  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    AlipayTxn.create(:notify_id => notification.notify_id, 
                     :total_fee => notification.total_fee, 
                     :status => notification.trade_status, 
                     :trade_no => notification.trade_no, 
                     :received_at => notification.notify_time)

    notification.acknowledge

    case notification.status
    when "WAIT_BUYER_PAY"
      @order.pend_payment!
    when "WAIT_SELLER_SEND_GOODS"
      @order.pend_shipment!
    when "WAIT_BUYER_CONFIRM_GOODS"
      @order.confirm_shipment!
    when "TRADE_FINISHED"
      @order.pay!
    else
      @order.fail_payment!
    end
  end
  
  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)  
    unless @result = r.success?  
      logger.warn(r.message)  
    end  
  end
end
