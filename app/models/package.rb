class Package < ApplicationRecord
  extend FuzzySearchable

  paginates_per ITEMS_PER_PAGE

  FUZZY_SEARCHABLE_ATTRIBUTES = ['title']

  has_many :package_versions
  has_one :latest_package_version, through: :latest_package_version_id
end
