namespace :cpan do
  desc "Fetch the latest index"
  task fetch_index: :environment do
    Cpan::Index::Manager.new.start
  end

  desc "Update latest version"
  task update_version: :environment do
    Cpan::PackageVersion::Manager.new.start
  end

end
