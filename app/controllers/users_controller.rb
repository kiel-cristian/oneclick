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
    @bookmarks = UserBookmark.where("users_id = ?", current_user.id).page(page).per(5)
  end

  def show
    # p current_user.inspect
    # @user = User.find(current_user)
    # p @user.inspect
    page = params[:page] or 1
    @user = current_user
    @bookmarks = UserBookmark.where("users_id = ?", current_user.id).page(page).per(5)
    @notice = params[:notice]

    # render action: 'info'
  end

  def delete_bookmark
    b_id = params[:id]
    bookmark = UserBookmark.where("users_id = ? and bookmarks_id = ?", current_user.id,b_id)
    bookmark.first.delete if bookmark.presence

    redirect_to action: 'show', id: current_user.id
  end

  def add_bookmark
    b_id = params[:id]

    if Bookmark.find(b_id).presence and UserBookmark.where("users_id = ? and bookmarks_id = ?", current_user.id,b_id).blank?
      ub = UserBookmark.new(users_id: current_user.id, bookmarks_id: b_id)
      if ub.save
        redirect_to action: 'show', id: current_user.id, notice: 'Bookmark agregado exitosamente' and return
      end
    else
      redirect_to controller: 'bookmarks', action: 'list',alert: 'Ya posees este bookmark' and return
    end
  end

end
