class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller? #cancan
  
  include SessionsHelper
  
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.fatal "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url, :flash => { :error => exception.message }
  end
  
end
