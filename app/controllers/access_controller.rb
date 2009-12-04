class AccessController < ActionController::Base
  def logout
    reset_session
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end