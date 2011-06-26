class HomeController < ApplicationController
  def index
    @user = User.new
    if current_user
      redirect_to newsfeed_path
    end
  end
  def new
  end

  def create
    @user = User.new(params[:user])
    if @user.save(:validate => false)
      redirect_to root_url, :notice => "Signed up!"
    else
      render "index"
    end
  end
  
  def newsfeed
    @status = Status.new
    friendships = Friendship.where(:user_id => current_user.id, :status => true)
    friends = friendships.collect {|f| User.find(f.friend_id)}
    @statuses = friends.collect {|f| f.statuses.where(:private => false)} + current_user.statuses
    @statuses.flatten!
    @statuses.sort! { |a,b| b.created_at <=> a.created_at }
  end
  
  

end
