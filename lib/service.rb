require 'dry-initializer'
require 'dry-validation'

class Service  
  extend Dry::Initializer
  
  def self.call(**args)    
    return false unless self::Schema.call(args).success?
    
    new(**args).call
  end
end