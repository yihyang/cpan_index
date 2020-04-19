module Cpan
  module PackageVersion
    module ContentParser
      class AttributeParser
        ALLOWED_ATTRIBUTES = [
          'Package',
          'Type',
          'Title',
          'Version',
          'Date',
          'Authors@R',
          'Depends',
          'Description',
          'Repository',
          'License',
          'NeedsCompilation',
          'Packaged',
          'Author',
          'Maintainer',
          'Date/Publication'
        ]

        def initialize(record)
          @record = record
        end

        def parse
          @record = join_multiline_contents(@record)
          filtered_record = @record.filter do |item|
            ALLOWED_ATTRIBUTES.include?(item[:key])
          end

          filtered_record = filtered_record.reduce({}) do |result, item|
            attribute_name = to_underscore_case(item[:key])
            method_name = "parse_#{attribute_name}".to_sym

            value = if AttributeParser.respond_to? method_name
              # if attribute method defined then parse it
              AttributeParser.send(method_name, item[:value])
            else
              # else return string
              item[:value]
            end

            result[attribute_name.to_sym] = value
            result
          end

          filtered_record = AuthorsMaintainersParser.new(filtered_record).parse

        end

        def to_underscore_case(value)
          value
          .gsub(/\W/, '') # replace non word characters
          .gsub(/(.)([A-Z])/, '\1_\2')
          .downcase
        end

        def join_multiline_contents(record)
          record
            .gsub(/\n\s+/, "\s") # join multiple items to single line for easier processing
            .gsub(/\s{2,}/, "\s") # remove additional spaces
            .split("\n").map do |line| # split line for processing
                matches = line.match(/^([\w\@\/]+)(?:\:)([^\n]+)/)

                if matches
                    {
                        key: matches[1],
                        value: matches[2].strip,
                    }
                end
            end.select { |item| item } # reject null items
        end

        class << self
          def parse_date_publication(value)
            DateTime::parse(value)
          end

          def parse_description(value)
            value
          end
        end
      end
    end
  end
end
