class StatusesController < ApplicationController
  
  def show
    @status = Status.find(params[:id])
  end
  
  def create
    @status = current_user.statuses.build(params[:status])
    @status.date = DateTime.strptime("{ #{@status.date_string} }", "{ %m/%d/%Y %H:%M }")
    @status.day_name = get_day_name(@status.date.month, @status.date.day)
    @status.week_num = get_week_num(@status.date.day)
    
    @status.save
    redirect_to newsfeed_path
  end
  
  def destroy
    @status = Status.find(params[:id])
    @status.do_withs.destroy
    @status.destroy
    redirect_to "calendar/index"
  end
  
  def comment
    status = Status.find(params[:status])
    comment = Comment.new(:comment => params[:comment], :status_id => status.id, :user_id => current_user.id)
    comment.save
    redirect_to newsfeed_path
  end
  def like
    like = Like.create!(:user_id => current_user.id, :status_id => params[:id])
    redirect_to newsfeed_path
  end
  
  def doweet_button
    status = Status.find(params[:id])
    if Friendship.where(:user_id => current_user.id, :friend_id => status.user_id).any?
    dowith = DoWith.new(:status_id => status.id, :friend_id => current_user.id) 
    if dowith.save
      redirect_to newsfeed_path
    else
      redirect_to newsfeed_path
    end
    else
      redirect_to newsfeed_path
    end
  end
  
  
  private
  

  
  def get_day_name(month, day_of_month )
    

     if month == 1
       month_num = 0
     elsif month == 2
       month_num = 3
     elsif month == 3
     month_num = 3
    elsif month == 4
     month_num == 6
       elsif month == 5
     month_num = 1
       elsif month == 6
     month_num = 4
       elsif month == 7
     month_num = 6
       elsif month == 8
     month_num = 2
       elsif month == 9
     month_num = 5
       elsif month == 10
     month_num = 0
       elsif month == 11
     month_num = 3
       elsif month == 12
     month_num = 5
     end




     day_formula = 6 + 11 + 11/4 + month_num + day_of_month  

     day_num = day_formula % 7

     if day_num == 0
     day_of_week = "Sunday"
       elsif day_num == 1
     day_of_week = "Monday"
       elsif day_num == 2
     day_of_week = "Tuesday" 
       elsif day_num == 3
     day_of_week = "Wednesday" 
       elsif day_num == 4
     day_of_week = "Thursday" 
       elsif day_num == 5 
     day_of_week = "Friday" 
       elsif day_num == 6 
     day_of_week = "Saturday" 
     end
     
    return day_of_week

  end
  

end