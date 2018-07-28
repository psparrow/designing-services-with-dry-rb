require 'dry-initializer'
require 'dry-validation'
require 'dry/monads/result'
require 'dry/core'

class Service  
  extend Dry::Initializer
  include Dry::Monads::Result::Mixin
  extend Dry::Core::ClassAttributes

  defines :permissible_errors
  permissible_errors []
  
  def self.call(**args)    
    validation = self::Schema.call(args)    
    return Failure.new(validation.errors) unless validation.success?
    
    new(**args).call
  rescue StandardError => error
    handle_error(error)     
  end

  def self.handle_error(error)
    raise error unless permissible_errors.any? { |type| type === error }  
    
    Failure.new(error)
  end
end