# class ApplicationController < ActionController::Base
  
# end


class ApplicationController < ActionController::Base
	protect_from_forgery
  before_filter :convert_hash
  after_filter :set_charset
  # ICONV = Iconv.new('ISO-8859-1', 'UTF-8')

  def set_charset
    content_type = headers["Content-Type"] || 'text/html'
    if /^text\//.match(content_type)
      headers["Content-Type"] = "#{content_type}; charset=iso-8859-1"
    end
  end

  def convert_hash
    if request.xhr?
         codificar(params)  # si es una llamada ajax, llamo al mÃ©todo codificar con los params
    end
  end

  def codificar(hash)
    hash.each_key  do |a|
      # hash[a] = ICONV.iconv(hash[a]) if hash[a].is_a?String   # si es cadena, le aplico el ICONV codificar
      hash[a] if hash[a].is_a? Hash # si es un hash, llamo a  esta misma funciÃ³n
    end
  end
end