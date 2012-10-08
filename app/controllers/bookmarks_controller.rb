#!/bin/env ruby
# encoding: utf-8
class BookmarksController < ApplicationController
	before_filter :authenticate_user!, :only=>['create', 'edit' ,'update' ,'delete','new']

	def index
		redirect_to action: 'list'
	end
	def list
		page = params[:page] or 1
		# bookmarks = Bookmark.order(:popularity).page(page).per(20)
		@bookmarks = Bookmark.order(:popularity).page(page).per(20)

		# @bookmarks = []

		# if bookmarks.presence
		# 	bookmarks.each do |b|
		# 		category_id = b.categories_id
		# 		category_name = Category.find(category_id).name

		# 		@bookmarks.append([url: b.url,popularity: b.popularity,security: b.security,category: category_name])
		# 	end
		# end

		# puts bookmarks.inspect
		# puts @bookmarks.inspect

     end

	def new
		@bookmark = Bookmark.new
		@categories = Category.all

		p @categories.inspect
	end

	def create
		puts params.inspect
		@categories = Category.all

		b = Category.where(id: params[:bookmarks][:category])
		if  b.presence
	  		if params[:bookmark][:url].blank? or params[:bookmarks][:category].blank?
	  			@errors = "Debe escribir una URL y seleccionar una categoria."
	  			# redirect_to action: 'new'

	  			render action: 'new'
	  		else
				bookmark = Bookmark.create(url: params[:bookmark][:url],categories_id: params[:bookmarks][:category],security: 0,popularity: 0)
				if bookmark.id.presence
					u_b = UserBookmark.new(users_id: current_user.id,bookmarks_id: bookmark.id)

					if u_b.save
						redirect_to action: 'list'
					else
						@errors = "No se pudo asociar bookmark al usuario"
						render action: 'new'
					end
				else
					@errors = "No se pudo guardar Bookmark, formato incorrecto de URL o Bookmark ya existe"
					render action: 'new'
				end
			end
		else
			@errors = "Categoría inválida"
			render action: "new"
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

	def increment
		#link_to "Ir al sitio", @bookmark.url, {onclick: 'increment_popularity();'
		id = params[:id]

		b = Bookmark.find(id)
		p = b.popularity + 1
		b.update_attributes(popularity: p)

		redirect_to b.url
	end
end
