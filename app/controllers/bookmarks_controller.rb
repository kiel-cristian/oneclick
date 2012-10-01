class BookmarksController < ApplicationController
	def index
		redirect_to action: 'list'
	end
	def list
		@bookmarks = Bookmark.all
	end

	def new
		@bookmark = Bookmark.new
		@categories = Category.all
	end

	def create
		puts params.inspect

  		if params[:bookmark][:url].blank? or params[:bookmarks][:categories_id].blank?
  			@errors = "Debe escribir una URL y seleccionar una categoria."
  			# redirect_to action: 'new'
  			@categories = Category.all

  			render action: 'new'
  		else
			@bookmark = Bookmark.new(url: params[:bookmark][:url],category: params[:bookmarks][:categories_id],security: 0,popularity: 0)
			if @bookmark.save
				redirect_to action: 'list'
			else
				redirect_to action: 'new'
			end
		end
	end
	
	def show
		@bookmark = Bookmark.find(params[:id])
	end

	def edit
		@bookmark = Bookmark.find(params[:id])
	end

	def update
		@bookmark = Bookmark.find(params[:id])

		if @bookmark.update_attributes(
			url: params[:url],
			category: params[:category],
			security: params[:security],
			popularity: params[:popularity]
			)
			redirect_to action: 'show', id: @bookmark
		else
			render action: 'edit'
		end
	end

	def delete
		UserBookmark.where(bookmarks_id: params[:id]).destroy
		Bookmark.find(params[:id]).destroy

		redirect_to action: 'list'
	end
end