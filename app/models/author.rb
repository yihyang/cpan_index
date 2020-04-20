class Author < ApplicationRecord
  belongs_to :package_version
  belongs_to :person
end
