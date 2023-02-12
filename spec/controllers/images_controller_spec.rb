require "stringio"
require "rails_helper"

RSpec.describe ImagesController, type: :controller do
  let(:user_credentials) do
    {
      email:    "testuser@email.com",
      password: "test12345"
    }
  end

  let(:current_user) { User.create(user_credentials) }

  let(:mission_model) do
    {
      "name"      => "TestMission",
      "status"    => "Successful",
      "latitude"  => 34.02,
      "longitude" => 12.23,
      "altitude"  => 60_700,
      "email"     => "testuser@email.com",
      "image"     => "dog-3.jpg"
    }
  end

  let(:mission) { Mission.new(mission_model) }
  let(:image) { Image.new(mission) }
  let(:mock_image) { StringIO.new("test image string") }

  let(:id) { 1 }

  before do
    sign_in current_user
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe "#show" do
    describe "When a mission is found and is successful" do
      before do
        allow(Mission).to receive(:where).and_return([mission])
        allow(image).to receive(:fetch_image).and_return(mock_image.read)
      end

      it "sends an image" do
        expect(controller).to receive(:send_data)
        get :show, params: { id: id }
      end
    end

    describe "When a mission is not found" do
      before do
        allow(Mission).to receive(:where).and_return([])
      end

      it "calls render :not_found" do
        expect(controller).to receive(:render).with({ status: :not_found })
        get :show, params: { id: id }
      end
    end
  end
end
