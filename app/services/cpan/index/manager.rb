module Cpan
  module Index
    class Manager
      def start
        records = FetchRecord.new.fetch_latest_version
        records.each do |record|
          PackageRecorder.new(record).record
        end
      end
    end
  end
end
