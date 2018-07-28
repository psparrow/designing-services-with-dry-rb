require_relative './service'

URL = 'foo'

class NotifySlack < Service
  Schema = Dry::Validation.Schema do
    required(:message).filled
  end

  option :message
  option :notifier, default: -> { Slack::Notifier.new(URL) }
  
  def call    
    ping_result = notifier.ping(message)      
    Success.new(ping_result)
  rescue StandardError
    Failure.new('slack error')    
  end
end