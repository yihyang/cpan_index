module Cpan
  module Index
    class Manager
      def start
        records = FetchRecord.new.fetch_latest_version

        puts "Fetched #{records.length} records"

        records.each do |record|
          PackageRecorder.new(record).record
        end
      end
    end
  end
end
