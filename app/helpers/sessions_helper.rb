module SessionsHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def admin?
    current_user.admin?
  end
  
  def check_permission
    redirect_to root_url, 
            :notice => "You are are not authorized to access this page." unless current_user.admin
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end
  
  def deny_access
    redirect_to root_url, :notice => "Please sign in to access this page."
    return false
  end
end
