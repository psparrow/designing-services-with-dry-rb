require 'dry-initializer'
require 'dry-validation'

URL = 'foo'

class NotifySlack
  Schema = Dry::Validation.Schema do
    required(:message).filled
  end

  extend Dry::Initializer

  option :message
  option :notifier, default: -> { Slack::Notifier.new(URL) }
  
  def self.call(**args)
    return false unless Schema.call(args).success?
    
    new(**args).call
  end

  def call
    notifier.ping(message)
  end
end