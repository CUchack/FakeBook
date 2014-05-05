#http://keighl.com/post/amistad-friendships-controller/
#https://github.com/raw1z/amistad/wiki/_pages
#http://thehungrycoder.com/ruby-on-rails/amistad-facebook-like-friendship-management-in-ror.html
class FriendshipsController < ApplicationController

  def index
    @friends = current_user.friends
  end

  def create
    user = User.find(params[:id])
    current_user.invite user
    redirect_to :back
  end

  def update
    user = User.find(params[:id])
    current_user.approve user
    redirect_to :back
  end

  def destroy
    user = User.find(params[:id])
    current_user.remove_friendship user
    redirect_to :back
  end
end
