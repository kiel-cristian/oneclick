class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def list
		@users = User.all
	end

	def create
		@user = User.new(name: params[:name],email: params[:email],password: params[:password])
		if @user.save
			redirect_to action: 'list'
		else
			# render action: 'create'
		end
	end
	
	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(name: params[:name],email: params[:email],password: params[:password])
			redirect_to action: 'show', id: @user
		else
			render action: 'edit'
		end
	end

	def delete
		UserBookmark.where(users_id: params[:id]).destroy
		User.find(params[:id]).destroy
		redirect_to action: 'list'
	end
end
