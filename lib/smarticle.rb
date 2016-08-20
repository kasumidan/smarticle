require "smarticle/engine"

module Smarticle
  mattr_accessor :owner_class
  mattr_accessor :check_auth_method
  
  def self.owner_class
    @@owner_class.constantize
  end
end
