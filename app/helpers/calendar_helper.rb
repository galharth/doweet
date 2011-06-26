module CalendarHelper
  

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
