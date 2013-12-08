require 'open-uri'

module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    order = (column == params[:sort] && params[:order] == 'asc') ? 'desc' : 'asc'
    link_to title, :sort =>column, :order => order
  end

  def filterable(column, term)
    if term == '' or term == nil
      term = '---'
    end
    link_to term, :term =>term, :filter => column 
  end

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

end
