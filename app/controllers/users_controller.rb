class UsersController < ApplicationController

  before_filter :authenticate_user! , only: ['show','change_password']

  after_filter :show2

  #API
  #'index'
  # :sign_in => 'login',
  # :sign_out => 'logout',
  # :password => 'secret',
  # :confirmation => 'confirm',
  # :unlock => 'unblock',
  # :registration => 'register',
  # :sign_up => 'signup'

  #HELPERS
  # user_signed_in?
  # current_user
  # user_session

  # def show
  #   redirect_to action: 'info'
  # end

  # def index
  #   redirect_to action: 'login'
  # end
  def show2
    page = params[:page] or 1
    @user = current_user
    @bookmarks = UserBookmark.where(users_id: current_user.id).page(page).per(5)
  end

  def show
    # p current_user.inspect
    # @user = User.find(current_user)
    # p @user.inspect
    page = params[:page] or 1
    @user = current_user
    @bookmarks = UserBookmark.where(users_id: current_user.id).page(page).per(5)
    @notice = params[:notice]

    # render action: 'info'
  end

  def delete_bookmark
    b_id = params[:id]
    bookmark = UserBookmark.where(users_id: current_user.id, bookmarks_id: b_id)
    bookmark.first.delete if bookmark.presence

    redirect_to action: 'show', id: current_user.id
  end

  def add_bookmark
    b_id = params[:id]

    if Bookmark.find(b_id).presence and UserBookmark.where(users_id: current_user.id,bookmarks_id: b_id).blank?
      ub = UserBookmark.new(users_id: current_user.id, bookmarks_id: b_id)
      if ub.save
        redirect_to action: 'show', id: current_user.id, notice: 'Bookmark agregado exitosamente' and return
      end
    else
      redirect_to controller: 'bookmarks', action: 'list',alert: 'Ya posees este bookmark' and return
    end
  end

  # def login
  #   if params[:username].blank? and params[:password].blank?
  #     @errors = "Ingrese nombre de usuario y password"
  #     render action: :login
  #   end
  # end

  # def change_password
  # end

  # def signup
  #   @user = User.new(@params[:user])
  #   if request.post?
  #     if @user.save
  #       session[:user] = User.authenticate(@user.login, @user.password)
  #       flash[:message] = "Signup successful"
  #       redirect_to :action => "welcome"
  #     else
  #       flash[:warning] = "Signup unsuccessful"
  #     end
  #   end
  # end

  # def login
  #   if request.post?
  #     if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
  #       flash[:message]  = "Login successful"
  #       redirect_to_stored
  #     else
  #       flash[:warning] = "Login unsuccessful"
  #     end
  #   end
  # end

  # def logout
  #   session[:user] = nil
  #   flash[:message] = 'Logged out'
  #   redirect_to :action => 'login'
  # end

  # def forgot_password
  #   if request.post?
  #     u= User.find_by_email(params[:user][:email])
  #     if u and u.send_new_password
  #       flash[:message]  = "A new password has been sent by email."
  #       redirect_to :action=>'login'
  #     else
  #       flash[:warning]  = "Couldn't send password"
  #     end
  #   end
  # end

  # def change_password
  #   @user=session[:user]
  #   if request.post?
  #     @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
  #     if @user.save
  #       flash[:message]="Password Changed"
  #     end
  #   end
  # end

  # def welcome
  # end
  # def hidden
  # end

end
