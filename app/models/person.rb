class Person < ApplicationRecord
  extend FuzzySearchable

  paginates_per ITEMS_PER_PAGE

  FUZZY_SEARCHABLE_ATTRIBUTES = ['name', 'email']

  has_many :authors
  has_many :package_versions, through: :authors
end
