class Person < ApplicationRecord
  extend FuzzySearchable

  paginates_per ITEMS_PER_PAGE

  FUZZY_SEARCHABLE_ATTRIBUTES = ['name', 'email']
end
