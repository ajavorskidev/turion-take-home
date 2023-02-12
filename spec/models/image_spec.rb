require "rails_helper"

RSpec.describe Image, type: :model do
  subject(:create) { described_class.new(mission) }

  let(:mission_model) do
    {
      "name"      => "TestMission",
      "status"    => "Successful",
      "latitude"  => 34.02,
      "longitude" => 12.23,
      "altitude"  => 60_700,
      "image"     => "dog-3.jpg"
    }
  end
  let(:mission) { Mission.new(mission_model) }

  describe "#intialize" do
    describe "when the model is initialized with a mission" do
      it "intializes the AWS S3 service client" do
        expect(create.service_client).to be_a Aws::S3::Client
      end

      it "sets the mission attribute " do
        expect(create.mission).to eq(mission)
      end
    end
  end
end
