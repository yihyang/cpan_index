class HomeController < ApplicationController
  SEARCH_PAGE_QUERY_LIMIT = 10
  def index; end

  def search
    query = params[:q]
    @people = Person.fuzzy_search(query).order(:name).limit(SEARCH_PAGE_QUERY_LIMIT)
    @packages = Package.fuzzy_search(query).order(:title).limit(SEARCH_PAGE_QUERY_LIMIT)
  end
end
