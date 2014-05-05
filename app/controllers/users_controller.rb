class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :friends]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    name =  params[:name]
    if name != nil
       key = "%#{name}%"
       @users = User.paginate(page: params[:page]).where("firstname LIKE ? or lastname LIKE ? or name LIKE ? or email LIKE ?", key, key, key, key)
       #.all( :conditions => ["name LIKE ?", "#{name}%"])
    else
       @users = User.paginate(page: params[:page])
    end
  end
  
  def feed
 #   @friend = User.find(params[:id])
    
  end
  
  def show 
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost  = current_user.microposts.build
    @users = @user.friends.paginate(page: params[:page])
#    render 'shared/micropost_form'

    @friends = current_user.friend_with? @user

  end
  
  def home
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    render 'shared/user_info'
  end
  def info
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to FakeBook!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])

  end
  
#  def clearwall
#    @user = User.find(params[:id])
#    @microposts = @user.microposts.all
#    for @microposts.each do |p|
#      p.destroy
#    end
#  end
  def user_info
        @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    render 'shared/user_info'
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Friends"
    @user = User.find(params[:id])
    @users = @user.friends.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    @followers = @user.followers
    @followed = @user.followed_users
#    @friends = @followed & @followers
#    @followers.each do |Seen|
#      @followed.each do |Watched|
       
#      end
#   end
  end  
  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :name, :email, :password, :password_confirmation, :interests, :quotes, :aboutyourself)
    end
  def micropost_params
    params.require(:micropost).permit(:content)
  end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

