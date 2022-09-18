require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/questions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/questions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/questions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/questions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
