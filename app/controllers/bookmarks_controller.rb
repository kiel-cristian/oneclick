#!/bin/env ruby
# encoding: utf-8
class BookmarksController < ApplicationController
	before_filter :authenticate_user!, :only=>['create', 'edit' ,'update' ,'delete','new','vote']

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
		@category = @category_names[@bookmark.categories_id.to_i]
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

		if b.security > -50
			p = b.popularity + 1
			b.update_attributes(popularity: p)
			redirect_to b.url
		else
			@alert = "El sitio esta catalogado como inseguro, por ende, no se recomienda visitarlo."
			@bookmark = Bookmark.find(id)
			@category = @category_names[@bookmark.categories_id.to_i]
			render action: "show", id: id
		end
	end

	def vote
		user_bookmark = UserBookmark.where(users_id: current_user.id, bookmarks_id: params[:id]).first
		if user_bookmark.presence
			prev_points = -1 * user_bookmark.vote.to_i

			d_id = params[:bookmark]
			@b_id = params[:id]
			@faults = Vote.all

			# "bookmark"=>{"fault"=>"1", "message"=>"El sitio ..."

			if d_id.presence
				fault 		= d_id[:fault]
				message 	= d_id[:message]

				if fault.presence and message.presence and message != 'El sitio ...'
					vote = BookmarksVote.new(bookmarks_id: @b_id,votes_id: fault,message: message)

					if vote.save
						# factor = get_factor(fault)
						points = get_points(fault)
						div = User.all.count

						bookmark = Bookmark.find(@b_id)

						bookmark.change_security(prev_points,1)
						bookmark.change_security(points,div)

						user_bookmark.update_attributes(vote: points/div)

						@notice = "Denuncia ingresada con éxito"

						redirect_to action: 'list'
						# denuncia ingresada
					else
						@alert = "No se pudo ingresar la denuncia"
					end
				else
					@alert = "Ingrese denuncia y un mensaje"
				end
			end
		else
			@alert = "Debe agregar este bookmark antes de votar"
		end

	end

	def get_points(id)
		vote_id = id.to_i

		# Vote.create(name: 'Inválido',description: 'La URL no existe, o dejo de existir')
		# Vote.create(name: 'Virus',description: 'La URL apunta a un sitio con contenido dañino')
		# Vote.create(name: 'Phishing',description: 'La URL apunta a un posible sitio de phishing')
		# Vote.create(name: 'Piratería',description: 'La URL apunta a un sitio que atenta contra derechos de autor')
		# Vote.create(name: 'Inadecuado',description: 'La URL apunta a un sitio de contenidos para adultos')
		# Vote.create(name: 'Pendiente',description: 'No sabe que tan segura es la URL')
		# Vote.create(name: 'Confiable',description: 'URL confiable debido a uso que se le ha dado')
		# Vote.create(name: 'Seguro',description: 'URL segura certificada')
		# Vote.create(name: 'Muy Seguro',description: 'URL segura certificada por varias entidades y manejo seguro de datos')

		# invalid     = (-200..-101)
		# insecure    = (-100..-50)
		# suspicious  = (-49..-20)
		# pending     = (-19..19)
		# confiable   = (20..49)
		# secure      = (50..100)
		# very        = (101..500)

		if vote_id == 1
			return -200
		elsif vote_id == 2
			return -100
		elsif vote_id == 3
			return -50
		elsif vote_id == 4
			return -49
		elsif vote_id == 5
			return -20
		elsif vote_id == 6
			return 0
		elsif vote_id == 7
			return 20
		elsif vote_id == 8
			return 50
		elsif vote_id == 9
			return 101
		end
	end

	def get_order
		return [{name: 'Popularidad', value: 'popularity'},{name: 'Seguridad', value: 'security'}]
  	end

  	def get_crecent
  		return [{value: ' ', name: 'Menor a Mayor'}, {value: 'DESC', name: 'Mayor a Menor'}]
  	end
end
