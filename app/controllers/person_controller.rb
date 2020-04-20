class PersonController < ApplicationController
  def index
    @people = Person.all.order(:name).page params[:page]
  end

  def search
    query = params[:q] || ''
    @people = Person.fuzzy_search(query).order(:name).page params[:page]
  end

  def show
    @person = Person.find(params[:id])
  end
end
