module UserSessionInfo
  def current_session_user
    Thread.current[:user]
  end

  def self.current_session_user=(user)
    Thread.current[:user] = user
  end


  def current_session_ip
    Thread.current[:ip]
  end

  def self.current_session_ip=(ip)
    Thread.current[:ip] = ip
  end
end