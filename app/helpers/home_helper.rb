module HomeHelper
def already_likes?(status, user)
Like.where(:status_id => status.id, :user_id => user.id ).size == 0
end

end
