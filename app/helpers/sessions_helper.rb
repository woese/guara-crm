# encoding: utf-8
module SessionsHelper
=begin
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    #logger.debug "HELPER Session: getCurrentUser User: #{@current_user} | TOKEN: #{cookies[:remember_token]} "
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
=end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to new_user_session_path, notice: t("session.erros.restrict_redirected")
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  def preferences_customer_type=(type)
    session[:customer_type] = type;
  end
  
  def preferences_customer_type?
    session[:customer_type] || :pj
  end
end