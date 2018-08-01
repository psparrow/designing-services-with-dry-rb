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
    email_result = emailer.send(to, body)

    if email_result
      Success.new(email_result)
    else
      Failure.new('email error')
    end
  end
end
