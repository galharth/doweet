class FriendshipsController < ApplicationController
  def index    
      query = params[:search]
      if query.present?
        @users = User.where("name LIKE ?", query)
      else
        @users = User.all
      end
  end
  def add
    @request = current_user.friendships.build(:friend_id => params[:friend_id])  
    @request.push
    redirect_to newsfeed_path
  end
  
  def confirm
    @request = Friendship.find(params[:id])
    @request.status = true
    @request.push
    @request_confrim = Friendship.new(:user_id => current_user.id, :friend_id => @request.user_id)
    @request_confrim.status = true
    @request_confrim.push
    redirect_to newsfeed_path
  end
  
  def decline  
    @request = Friendship.find(params[:id])
    if @request.destroy
      redirect_to requests_path
    else
      render "requests"
    end
  end
  
  def requests
    @requests = Friendship.find_all_by_friend_id(current_user.id)
  end
  
end


 
