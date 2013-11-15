module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    order = (column == params[:sort] && params[:order] == 'desc') ? 'asc' : 'desc'
    link_to title, :sort =>column, :order => order
  end

end
