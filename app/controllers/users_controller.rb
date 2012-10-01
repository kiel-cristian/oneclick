# class UsersController < ApplicationController
	# def new
	# 	@user = User.new
	# end

	# def list
	# 	@users = User.all
	# end

	# def create
	# 	@user = User.new(name: params[:name],email: params[:email],password: params[:password])
	# 	if @user.save
	# 		redirect_to action: 'list'
	# 	else
	# 		# render action: 'create'
	# 	end
	# end
	
	# def show
	# 	@user = User.find(params[:id])
	# end

	# def edit
	# 	@user = User.find(params[:id])
	# end

	# def update
	# 	@user = User.find(params[:id])

	# 	if @user.update_attributes(name: params[:name],email: params[:email],password: params[:password])
	# 		redirect_to action: 'show', id: @user
	# 	else
	# 		render action: 'edit'
	# 	end
	# end

	# def delete
	# 	UserBookmark.where(users_id: params[:id]).destroy
	# 	User.find(params[:id]).destroy
	# 	redirect_to action: 'list'
	# end
class UsersController < ApplicationController

  before_filter :login_required, :only=>['welcome', 'change_password', 'hidden']

  def signup
    @user = User.new(@params[:user])
    if request.post?  
      if @user.save
        session[:user] = User.authenticate(@user.login, @user.password)
        flash[:message] = "Signup successful"
        redirect_to :action => "welcome"          
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
        redirect_to_stored
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:message]="Password Changed"
      end
    end
  end

  def welcome
  end
  def hidden
  end
end
# end
