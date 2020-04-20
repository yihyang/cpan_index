require 'rails_helper'

RSpec.describe "Packages", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/package/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search" do
    it "returns http success" do
      get "/package/search"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/package/show"
      expect(response).to have_http_status(:success)
    end
  end

end
