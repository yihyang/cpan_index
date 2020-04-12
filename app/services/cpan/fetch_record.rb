module Cpan
  class FetchRecord
    include ::HTTParty
    base_uri 'http://cran.r-project.org'

    def fetch_latest_version
      self.class.get('/src/contrib/PACKAGES').split("\n\n")
    end
  end
end
