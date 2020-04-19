class Package < ApplicationRecord
  has_many :package_versions
  has_one :latest_package_version, through: :latest_package_version_id
end
