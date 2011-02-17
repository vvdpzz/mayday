# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mayday::Application.initialize!

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)
ActiveMerchant::Billing::Integrations::Alipay::KEY = "va5u8tmt5icq2twocvlsd883biqoj504"
ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = "2088102001145231"
ActiveMerchant::Billing::Integrations::Alipay::EMAIL = "vvdpzz@gmail.com"
