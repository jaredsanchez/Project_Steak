require 'open-uri'

module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    search_terms = params[:search_term]
    filter = params[:filter]
    term = params[:term] 
    order = (column == params[:sort] && params[:order] == 'asc') ? 'desc' : 'asc'
    link_to title, :sort =>column, :order => order, :search_term => search_terms, :term => term, :filter => filter
  end

  def filterable(column, term, title = nil)
    title ||= term
    if title == '' or title == nil
      title = '---'
    end
    link_to title, :term =>term, :filter => column
  end

  def link_to_filter(column, term, path, title = nil)
    title ||=term
    if title == '' or title == nil
      title = '---'
    end
    link_path = path+'_path'
    link_to title, send(link_path, :term => term, :filter => column)
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
