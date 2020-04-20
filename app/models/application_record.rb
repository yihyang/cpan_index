class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ITEMS_PER_PAGE = 50
end
