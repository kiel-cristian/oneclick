class BookmarksController < ApplicationController
	before_filter :authenticate_user!, :only=>['create', 'edit' ,'update' ,'delete','new']

	def index
		redirect_to action: 'list'
	end
	def list
		page = params[:page] or 1
		bookmarks = Bookmark.order(:popularity).page(page).per(20)
		@bookmarks = []

		if bookmarks.presence
			bookmarks.each do |b|
				category_id = b.categories_id
				category_name = Category.find(category_id).name

				@bookmarks.append([url: b.url,popularity: b.popularity,security: b.security,category: category_name])
			end
		end

		puts bookmarks.inspect
		puts @bookmarks.inspect
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
			@bookmark = Bookmark.new(url: params[:bookmark][:url],categories_id: params[:bookmarks][:categories_id],security: 0,popularity: 0)
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
