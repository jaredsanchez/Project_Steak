module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    order = (column == params[:sort] && params[:order] == 'asc') ? 'desc' : 'asc'
    link_to title, :sort =>column, :order => order
  end

end
