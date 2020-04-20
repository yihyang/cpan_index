class PackagesController < ApplicationController
  def index
    @packages_length = Package.all.length
    @packages = Package.all.page params[:page]
  end

  def search
    query = params[:q] || ''
    @packages = Package.fuzzy_search(query).page params[:page]
  end

  def show
    @package = Package.includes(latest_package_version: [:maintainer, authors: :person], package_versions: [authors: :person]).find(params[:id])
    @latest_version = @package.latest_package_version
  end
end
