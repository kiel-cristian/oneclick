#!/bin/env ruby
# encoding: utf-8
class ApplicationController < ActionController::Base
	protect_from_forgery
  before_filter :set_locale,:set_charset, :set_category_names, :set_security_names

def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
end

def default_url_options(options={})
  logger.debug "default_url_options is passed options: #{options.inspect}\n"
  { :locale => I18n.locale }
end

def set_charset
  headers["Content-Type"] = "text/html; charset=utf-8"
end

def set_category_names
	cat = Category.all

	@category_names = []

	cat.each do |c|
		@category_names[c.id.to_i] = c.name
	end

	# p @category_names
	# @category_names = Category.all.first.name

end

def set_security_names
  invalid     = (-200..-101)
  insecure    = (-100..-50)
  suspicious  = (-49..-20)
  pending     = (-19..19)
  confiable   = (20..49)
  secure      = (50..100)
  very        = (101..500)

  @security_names = { 	invalid		=> "<p class='notice_black'>Inválido" ,
  						insecure	=> "<p class='notice_red'>Inseguro",
  						suspicious 	=> "<p class='notice_orange'>Sospechoso",
  						pending		=> "<p class='notice_yellow'>Pendiente</p>",
  						confiable 	=> "<p class='notice_purple'>Confiable",
  						secure 		=> "<p class='notice_blue'>Seguro",
  						very 		=> "<p class='notice_green'>Muy Seguro"}
end


end