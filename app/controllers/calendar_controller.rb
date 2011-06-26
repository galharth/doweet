class CalendarController < ApplicationController
    
def index
  do_withs = DoWith.where(:friend_id => current_user.id)
  @statuses = do_withs.collect { |f| f.status_id }
  @statuses = @statuses.collect { |f| Status.find(f) }
  @statuses = @statuses + current_user.statuses 
  @statuses.flatten!
  @statuses.sort! { |a,b| a.date <=> b.date }
  
  @next = params[:next]
  
  @week_num = get_week_num(Time.now.day) + @next.to_i
  @days_names = ["Sunday", "Monday","Tusday", "Wednesday","Thursday", "Friday","Saturday"]
  @days = [[],[],[],[],[],[],[]]
  i = 0
  @statuses.each do |s|
    if s.week_num == @week_num
    while i < 7
    if s.day_name == @days_names[i]
         @days[i][@days[i].length] = s
    end
    i += 1
    end
    i = 0
  end 	     
end
  	
end


def monthcalendar     
  do_withs = DoWith.where(:friend_id => current_user.id)
  @statuses = do_withs.collect { |f| f.status_id }
  @statuses = @statuses.collect { |f| Status.find(f) }
  @statuses = @statuses + current_user.statuses 
  @statuses.flatten!		
  @date = params[:month] ? Date.parse(params[:month]) : Date.today
end


  
end
