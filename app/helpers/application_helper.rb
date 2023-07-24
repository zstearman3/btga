module ApplicationHelper
  def full_title(page_title)
    return page_title + " | BTGA" if page_title
    
    "BTGA"
  end
end
