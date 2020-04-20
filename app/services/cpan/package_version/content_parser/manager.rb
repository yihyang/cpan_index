module Cpan
  module PackageVersion
    module ContentParser
      class Manager
        def initialize(content)
          @content = content
        end

        def parse
          AttributeParser.new(@content).parse
        end
      end
    end
  end
end
