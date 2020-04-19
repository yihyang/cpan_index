class Package < ApplicationRecord
  extend FuzzySearchable

  paginates_per ITEMS_PER_PAGE

  FUZZY_SEARCHABLE_ATTRIBUTES = ['title']

  has_many :package_versions
  belongs_to :latest_package_version, class_name: 'PackageVersion', foreign_key: 'latest_package_version_id'
end
