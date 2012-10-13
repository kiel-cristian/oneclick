#!/bin/env ruby
# encoding: utf-8
class BookmarksController < ApplicationController
	before_filter :authenticate_user!, :only=>['create', 'edit' ,'update' ,'delete','new']

	def index
		redirect_to action: 'list'
	end
	def list
		@categories = Category.get_names()
		@order = ['Categoría','Popularidad','Seguridad']
		@crecent = ['Creciente', 'Decreciente']
		@alert = params[:alert]

		if params[:page].presence
			page = params[:page]
		else
			page = 1
		end

		if params[:order].presence
			order_option = params[:order]
		else
			order_option = 'popularity'
		end

		@bookmarks = Bookmark.order(order_option + ' DESC' ).page(page).per(5)
    end

    def search
    	p "PARAMS"
    	p params.inspect

  		@categories = Category.get_names()
		@order = get_order()
		@crecent = get_crecent()
		@alert = params[:alert]

    	if params[:select].presence and params[:select][:order].presence
			order_option = params[:select][:order]
		else
			order_option = 'popularity'
		end

		if params[:select] and params[:select][:category].presence
			if params[:select][:category] == "0"
				category = true
			else
				category = params[:select][:category]
			end
		else
			category = true
		end

		if params[:select].presence and params[:select][:crecent].presence
			crecent = params[:select][:crecent]
		else
			crecent = ''
		end

		if category == true
			@bookmarks = Bookmark.order(order_option + ' ' + crecent )
		else
			@bookmarks = Bookmark.where(categories_id: category).order(order_option + ' ' + crecent)
		end

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

	def denunce
		d_id = params[:bookmark]
		@b_id = params[:id]
		@faults = Denunce.all

		# "bookmark"=>{"fault"=>"1", "message"=>"El sitio ..."

		if d_id.inspect
			fault 		= d_id[:fault]
			message 	= d_id[:message]
			denunce = BookmarksDenunce.new(bookmarks_id: @b_id,denunces_id: fault,message: message)

			if denunce.save
				factor = get_factor(fault)
				points = get_points(fault)
				div = User.all.count

				bookmark = Bookmark.find(@b_id)
				bookmark.change_security(factor,points,div)
				@notice = "Denuncia ingresada con éxito"
				# denuncia ingresada
			else
				@alert = "No se pudo ingresar la denuncia"
			end
		end

	end

	def get_factor(denunce_id)
		if denunce_id == 1
			return 50
		elsif denunce_id == 2
			return 25
		elsif denunce_id == 3
			return 20
		elsif denunce_id == 4
			return 10
		elsif denunce_id == 5
			return 5
		else
			return 1
		end
	end

	def get_points(denunce_id)
		return 1
	end

	def get_order
		return [{name: 'Popularidad', value: 'popularity'},{name: 'Seguridad', value: 'security'}]
  	end

  	def get_crecent
  		return [{value: ' ', name: 'Menor a Mayor'}, {value: 'DESC', name: 'Mayor a Menor'}]
  	end
end
