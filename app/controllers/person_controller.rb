class PersonController < ApplicationController
  def index
    @people_length = Person.all.length
    @people = Person.all.order(:name).page params[:page]
  end

  def search
    query = params[:q] || ''
    @people = Person.fuzzy_search(query)
    @people_length = @people.length
    @people = @people.order(:name).page params[:page]
  end

  def show
    @person = Person.includes([:maintains, :package_versions, authors: [package_version: [:package]]]).find(params[:id])
  end
end
