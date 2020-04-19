module Cpan
  module PackageVersion
    module ContentParser
      # Authors and Maintainers will need a new class
      # due to it's references to multiple attributes
      class AuthorsMaintainersParser
        def initialize(records)
          @records = records
        end

        def parse
          @records[:authors] = parse_authors(@records)
          @records[:maintainer] = parse_maintainer(@records)

          @records
        end

        private

        def parse_authors(records)
          # build maintainer
          # check for items that existed in an array / single record
          authors_match = records[:author].scan(/([\w\.\s\-]+\[[\w\,\s]+\])/) # "Sébastien Auclair [ctb]"
          if authors_match
            authors_match.flatten.map do |author|
              # check for individual items after being captured through capture group
              author_match = author.match(/([\w\s\-\.]+)\[([\,\s\w]+)\]/) # "Sébastien Auclair [ctb]"
              item = {
                name: author_match[1].strip,
                role: author_match[2].split(', ')
              }

              # email data exists
              if records['authors_r']
                first_name = item[:name].split(' ')[0]
                email_match = records['authors_r'].match(/#{first_name}[\\\"\,\s\w\=]+email(?:\s)\=(?:\s)\"([\w\.\@\-]+)/)

                if email_match
                  item[:email] = email_match[1]
                end
              end

              item
            end
          else
            [record['author']]
          end
        end

        def parse_maintainer(records)
          return unless records[:maintainer]
          maintainer_with_email_pattern = /([\w\s\,\.]+)\<([\w\.\@\-]+)\>/
          maintainer = if maintainer_with_email_pattern = records[:maintainer].match(maintainer_with_email_pattern)
            {
              name: maintainer_with_email_pattern[1].strip,
              email: maintainer_with_email_pattern[2],
            }
          else
            {
              name: records[:maintainer]
            }
          end

          maintainer
        end
      end
    end
  end
end
