require 'dry-initializer'
require 'dry-validation'
require 'dry/monads/result'

class Service  
  extend Dry::Initializer
  include Dry::Monads::Result::Mixin
  
  def self.call(**args)    
    validation = self::Schema.call(args)    
    return Failure.new(validation.errors) unless validation.success?
    
    new(**args).call
  end
end