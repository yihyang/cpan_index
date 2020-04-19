module Cpan
  module PackageVersion
    class Manager
      def start
        package_versions = ::PackageVersion.where(status: ::PackageVersion::CREATED_STATUS)
        package_versions.each do |version|
          # fetch data
          file = FetchVersion.new(version).fetch
          raw_record =  FileParser.new(file).parse
          parsed_record = ContentParser::Manager.new(raw_record).parse
          RecordCreator.new(raw_record, parsed_record).create
        end
      end
    end
  end
end
