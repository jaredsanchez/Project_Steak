require 'open-uri'

module ApplicationHelper

<<<<<<< HEAD
=======
  class NetworkError < RuntimeError ; end

  def getXML(uri)
    begin
      doc = Nokogiri::XML(open(uri))
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
        Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
        Net::ProtocolError => e 
        raise ProjectSteak::NetworkError, e
    end
  end

>>>>>>> acf78c2e4734a05faeabbd6ec8641254aeaf0e35
  def sortable(column, title = nil)
    title ||= column.titleize
    order = (column == params[:sort] && params[:order] == 'asc') ? 'desc' : 'asc'
    link_to title, :sort =>column, :order => order
  end
<<<<<<< HEAD

=======
>>>>>>> acf78c2e4734a05faeabbd6ec8641254aeaf0e35
end
