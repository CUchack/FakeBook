class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :friends]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def micropost
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @microposts = @user.microposts.paginate(page: params[:page])

  end
end