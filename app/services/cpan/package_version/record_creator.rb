module Cpan
  module PackageVersion
    class RecordCreator
      def initialize(raw_record, parsed_record)
        @raw_record = raw_record
        @parsed_record = parsed_record
      end

      def create
        package = ::Package.find_by(title: @parsed_record[:package])

        return unless package

        package_version = ::PackageVersion.find_by(package_id: package.id, version_number: @parsed_record[:version])

        return unless package_version
        package_version.update(
          status: ::PackageVersion::COMPLETED_STATUS,
          description_raw_data: @raw_record,
          description: @parsed_record[:description]
        )

        package.update(
          latest_package_version_id: package_version.id
        )

        # maintainer
        maintainer_record = @parsed_record[:maintainer]

        return unless maintainer_record

        maintainer = Person::find_or_create_by(name: maintainer_record[:name])
        maintainer.update(email: maintainer_record[:email])
        package_version.update(
          maintainer_id: maintainer.id
        )

        # authors
        authors_record = @parsed_record[:authors]

        authors_record.each do |author_record|
          author = Person::find_or_create_by(name: author_record[:name])
          author.update(email: author_record[:email])

          # sometimes the roles of the author are not specified
          if author_record[:roles]
            author_record[:roles].each do |role|
              Author.find_or_create_by(
                package_version_id: package_version.id,
                person_id: author.id,
                role: role
              )
            end
          else
            Author.find_or_create_by(
              package_version_id: package_version.id,
              person_id: author.id,
            )
          end
        end
      end
    end
  end
end
