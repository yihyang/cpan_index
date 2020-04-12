module Cpan
  class PackageRecorder
    def initialize(raw_data)
      @raw_data = raw_data
    end

    def record
      attributes = parse_raw_data(@raw_data)
      package = Package.find_or_create_by(title: attributes[:package])
      package_version = PackageVersion.find_by(package_id: package.id, version_number: attributes[:version])

      return if package_version

      PackageVersion.create(
        package_id: package.id,
        version_number: attributes[:version],
        status: 'created',
        index_raw_data: @raw_data
      )
    end

    private

    def parse_raw_data(raw_data)
      raw_data.gsub!("\n\s", "\s") # joining multiline items
      raw_data.split("\n").map do |item|

        attributes = item.split(': ')
        attributes[0] = attributes[0].underscore.to_sym

        puts attributes.to_json
        attributes
      end.to_h
    end
  end
end
