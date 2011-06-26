class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_week_num(day_num)
    day_num += 3
    if day_num < 8
       week_num = 1 
    elsif day_num > 7 && day_num <= 14
      week_num = 2  
    elsif day_num > 14 && day_num <= 21 
      week_num = 3
    elsif day_num > 21 && day_num <= 28
      week_num = 4   
    elsif
      week_num = 5 
    end
    return week_num
  end

  
  
end
