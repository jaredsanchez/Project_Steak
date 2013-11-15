require 'open-uri'

module ApplicationHelper

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

  def sortable(column, title = nil)
    title ||= column.titleize
    order = (column == params[:sort] && params[:order] == 'asc') ? 'desc' : 'asc'
    link_to title, :sort =>column, :order => order
  end
end
