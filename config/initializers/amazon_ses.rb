creds = Aws::Credentials.new(ENV['AWS_KEY_ID'], ENV['AWS_ACCESS_KEY'])

Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials: creds,
  region: 'us-east-2'
)
