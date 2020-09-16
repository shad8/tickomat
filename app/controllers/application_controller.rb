class ApplicationController < ActionController::Base
  def pagination(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end
end
