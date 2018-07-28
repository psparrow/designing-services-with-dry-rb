require_relative './slack_notifier'
require_relative '../lib/notify_slack'
require 'pry'

SLACK_WEBHOOK_URL = '12345'

RSpec.describe NotifySlack do   
  context 'when provided an invalid message' do 
    it 'returns false' do 
      result = described_class.call(message: '')
      
      expect(result).to be_failure
    end    
  end

  context 'when provided valid arguments' do 
    it 'works' do 
      result = described_class.call(message: 'Hello World!')
      
      expect(result).to be_success
    end
  end
end