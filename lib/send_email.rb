require 'dry-initializer'
require 'dry-validation'
require 'uri'

class SendEmail
  Schema = Dry::Validation.Schema do
    required(:to).value(format?: URI::MailTo::EMAIL_REGEXP)
    required(:body).filled
  end

  extend Dry::Initializer

  option :to
  option :body
  option :emailer, default: -> { MyMailer }
  
  def self.call(**args)    
    return false unless Schema.call(args).success?
    
    new(**args).call
  end

  def call
    emailer.send(to, body)
  end
end