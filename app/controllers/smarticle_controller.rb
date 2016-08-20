class SmarticleController < ApplicationController
  protected
    def check_auth
      if Smarticle.owner_class.present?
        auth_method_name = "authenticate_" +Smarticle.owner_class.to_s.downcase + "!"
        send(auth_method_name)
      end
    end
end
