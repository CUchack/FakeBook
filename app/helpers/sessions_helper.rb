module SessionsHelper
	def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end
  def signed_in?
    !current_user.nil?
  end
  def current_user=(user)
    @current_user = user
  end
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  
  def my_feed(user)
    @self = user[:id]
    @friendslist = [@self,2,3,5,1,4,6] #change this to user.friends when friends are implemented
    @postlist = []
    for friend in @friendslist do
      @post = [Micropost.find_by_user_id(friend)]
      @postlist.concat(@post)
    end
    @postlist.sort{ |x,y| y.created_at <=> x.created_at}
    @postlist[0..10]
  end

end
