require 'rails_helper'

RSpec.describe LecturesController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST create" do
    it "returns http success" do
      new_track = create :track
      new_user = create :user

      post :create, lecture: build(:lecture, track: new_track, user: new_user).attributes
      expect(response.status).to eq 201
    end
  end

  describe "GET edit" do
    it "returns http success" do
      event = create :lecture
      get :edit, id: event.id
      expect(response).to be_success
    end
  end

  describe "PUT update" do
    it "returns http success" do
      event = create :lecture
      put :update, id: event.id, lecture: event.attributes
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "returns http success" do
      event = create :lecture
      get :show, id: event.id
      expect(response).to be_success
    end
  end
end
