require_relative './service'
require 'uri'

class SendEmail < Service
  Schema = Dry::Validation.Schema do
    required(:to).value(format?: URI::MailTo::EMAIL_REGEXP)
    required(:body).filled
  end

  option :to
  option :body
  option :emailer, default: -> { MyMailer }
  
  def call
    emailer.send(to, body)
  end
end