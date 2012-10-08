class ApplicationController < ActionController::Base
	protect_from_forgery
  before_filter :set_locale,:set_charset

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

# def after_sign_in_path_for(resource)
#   user_url = 'users#info'
#   stored_location_for(resource) ||
#     if resource.is_a?(User)
#       :users
#     else
#       super
#     end
# end


end