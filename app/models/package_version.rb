class PackageVersion < ApplicationRecord
  extend FuzzySearchable

  CREATED_STATUS = 'created'
  COMPLETED_STATUS = 'completed'

  belongs_to :package
  has_one :maintainer, through: :maintainer_id
end
