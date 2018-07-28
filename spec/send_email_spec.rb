require_relative './my_mailer'
require_relative '../lib/send_email'
require 'pry'

RSpec.describe SendEmail do   
  context 'when provided an invalid body' do 
    it 'returns false' do 
      result = described_class.call(to: 'asdf@jkl.com', body: '')
      
      expect(result).to be_failure
    end    
  end

  context 'when provided an invalid to address' do 
    it 'returns false' do 
      result = described_class.call(to: 'not-an-email-address', body: 'foo')
      
      expect(result).to be_failure
    end    
  end

  context 'when provided valid arguments' do 
    it 'works' do 
      result = described_class.call(to: 'test@test.com', body: 'foo')
      
      expect(result).to be_success 
    end
  end
end