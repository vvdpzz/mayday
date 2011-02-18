require 'net/http'
require 'active_merchant/billing/integrations/alipay/sign'
require 'cgi'
require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Alipay
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          include Sign

          def complete?
            trade_status == "TRADE_SUCCESS" or trade_status == "TRADE_FINISHED"
          end
        end
      end
    end
  end
end

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Alipay
        class Helper < ActiveMerchant::Billing::Integrations::Helper

          def sign
            add_field('sign',
                      Digest::MD5.hexdigest((@fields.sort.collect{|s|s[0]+"="+CGI.unescape(s[1])}).join("&")+KEY)
                     )
            add_field('sign_type', 'MD5')
            nil
          end

        end
      end
    end
  end
end
