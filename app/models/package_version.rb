class PackageVersion < ApplicationRecord
  extend FuzzySearchable

  CREATED_STATUS = 'created'
  COMPLETED_STATUS = 'completed'

  belongs_to :package
  # belongs_to :package, through: :package_version
  belongs_to :maintainer, class_name: 'Person', foreign_key: :maintainer_id, optional: true

  has_many :authors
  has_many :person, through: :authors
end
