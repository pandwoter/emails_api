SparkPostRails.configure do |c|
  c.api_key = ENV['SPARKPOST_API_KEY']
  c.sandbox = true
end
