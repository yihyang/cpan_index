require 'zlib'

module Cpan
  module PackageVersion
    class FileParser
      def initialize(file)
        @file = file
      end

      def parse
        @file = Zlib::GzipReader.new @file
        tar_extract = Gem::Package::TarReader.new(@file)
        # tar_extract.rewind # The extract has to be rewinded after every iteration
        records = []
        file = tar_extract.each do |entry|
            next unless entry.full_name.match(/DESCRIPTION$/)
          records << entry.read
        end
        tar_extract.close

        records[0]
      end
    end
  end
end
