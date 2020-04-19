module FuzzySearchable
  def fuzzy_search(string)
    parsed_string = "%#{string.downcase}%"
    searchable_attributes = self::FUZZY_SEARCHABLE_ATTRIBUTES
    return self.all if searchable_attributes.length == 0

    query = self.where("lower(#{searchable_attributes[0]}) LIKE ?", parsed_string)

    if searchable_attributes.length > 1
      searchable_attributes[1..-1].each do |attribute|
        query.or(self.where("lower(#{attribute}) LIKE ?", parsed_string))
      end
    end

    query
  end
end
