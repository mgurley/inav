# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include UserSessionInfo
  include ExceptionNotifiable
  ExceptionNotifier.exception_recipients = INAV_CONFIG[:exception_notifier][:exception_recipients]
  ExceptionNotifier.sender_address = INAV_CONFIG[:exception_notifier][:sender_address]
  ExceptionNotifier.email_prefix = INAV_CONFIG[:exception_notifier][:email_prefix]

  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :update_activity_time, :except => :session_expiry
  before_filter :set_user_session
  before_filter :clear_duplicate_patient

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :except => :session_expiry # :secret => 'c110e66b913d7a0634465784e2f147c0',
  layout 'application', :except => :session_expiry

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  def clear_duplicate_patient
    session[:duplicate_patient] = {}
  end

  def update_activity_time
    session_expiry
    session[:expires_at] = 30.minutes.from_now
  end

  def session_expiry
    unless session[:expires_at].nil?
      @time_left = (session[:expires_at] - Time.now).to_i
      unless @time_left > 0
        reset_session
        respond_to do |format|
          format.js { render :update do |page| page << "window.location ='#{logout_path}'" end }
          format.html { redirect_to logout_path }
        end
      end
    end
  end

  protected
   # Sets the current user into a named Thread location so that it can be accessed
   # by models and observers
  def set_user_session
    UserSessionInfo.current_session_user = session[:cas_user]
    UserSessionInfo.current_session_ip = request.remote_ip
  end
end