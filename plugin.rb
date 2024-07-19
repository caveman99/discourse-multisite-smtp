# frozen_string_literal: true

# name: discourse-multisite-smtp
# about: A plugin to enable SMTP settings for each multisite
# version: 0.0.3
# authors: Lhc_fl, caveman99
# url: https://github.com/caveman99/discourse-multisite-smtp
# required_version: 3.0.0

enabled_site_setting :discourse_multisite_email_enabled

after_initialize do
  
  DiscourseEvent.on(:before_email_send) do |*params|

    if SiteSetting.discourse_multisite_email_enabled
      message, type = *params
      message.delivery_method.settings[:authentication] = SiteSetting.discourse_multisite_email_smtp_authentication_mode
      message.delivery_method.settings[:address] = SiteSetting.discourse_multisite_email_smtp_address
      message.delivery_method.settings[:port] = SiteSetting.discourse_multisite_email_smtp_port
      message.delivery_method.settings[:password] = SiteSetting.discourse_multisite_email_smtp_password
      message.delivery_method.settings[:user_name] = SiteSetting.discourse_multisite_email_smtp_username
    end
  
  end
  
end

# message.delivery_method.settings is like:
# {:address=>"localhost",
#  :port=>1025,
#  :domain=>"localhost.localdomain",
#  :user_name=>nil,
#  :password=>nil,
#  :authentication=>nil,
#  :enable_starttls=>nil,
#  :enable_starttls_auto=>true,
#  :openssl_verify_mode=>nil,
#  :ssl=>nil,
#  :tls=>nil,
#  :open_timeout=>5,
#  :read_timeout=>5,
#  :return_response=>true}
