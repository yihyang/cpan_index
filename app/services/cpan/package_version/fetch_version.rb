module Cpan
  module PackageVersion
    class FetchVersion
      include ::HTTParty
      base_uri 'cran.r-project.org'

      def initialize(version)
        @version = version
      end

      def fetch
        package_title = @version.package.title
        version_number = @version.version_number
        file_name = "#{package_title}_#{version_number}.tar.gz"
        base_uri = 'http://cran.r-project.org'
        url = base_uri + "/src/contrib/#{file_name}"

        file = Net::HTTP.get(URI.parse(url))
        string_io = StringIO.new(file)

        string_io
      end
    end
  end
end
