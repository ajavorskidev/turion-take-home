require "rails_helper"

RSpec.describe Mission, type: :model do
  subject(:valid_parameter_mission) { described_class.new(model) }

  let(:model) do
    {
      "name"      => "TestMission",
      "status"    => "Planned",
      "latitude"  => 34.02,
      "longitude" => 12.23,
      "altitude"  => 60_700
    }
  end

  let(:params) do
    {
      mission: {
        status:   "In Progress",
        altitude: 40_000
      }
    }
  end

  describe "#initialize" do
    describe "when the model is initialized with valid attributes" do
      it "sets the attributes correctly" do
        expect(valid_parameter_mission.name).to eq("TestMission")
        expect(valid_parameter_mission.status).to eq("Planned")
        expect(valid_parameter_mission.latitude).to eq(34.02)
        expect(valid_parameter_mission.longitude).to eq(12.23)
        expect(valid_parameter_mission.altitude).to eq(60_700)
      end
    end
  end

  describe "#update_parameters" do
    subject(:update_mission) { described_class.new(model) }

    describe "when the update_parameters method is called with valid parameters" do
      it "updates the Mission object and return nil" do
        status = update_mission.update_parameters(params)
        expect(update_mission.status).to eq("In Progress")
        expect(update_mission.altitude).to eq(40_000)
        expect(status).to eq(nil)
      end
    end

    describe "when the update_parameters method is called and mission status is not Planned" do
      # subject { described_class.new(model) }

      let(:model) do
        {
          "name"      => "TestMission",
          "status"    => "In Progress",
          "latitude"  => 34.02,
          "longitude" => 12.23,
          "altitude"  => 60_700
        }
      end

      describe "and params includes other parameters than status" do
        let(:params) do
          {
            status:  "Failed",
            mission: {
              status:   "Failed",
              altitude: 40_000
            }
          }
        end

        it "returns 400 and not update the Mission object" do
          status = update_mission.update_parameters(params)
          expect(update_mission.status).to eq("In Progress")
          expect(update_mission.altitude).to eq(60_700)
          expect(status).to eq(400)
        end
      end

      describe "and params only includes status" do
        let(:params) do
          {
            status:  "Failed",
            mission: {
              status: "Failed"
            }
          }
        end

        it "returns nil and update the model" do
          status = update_mission.update_parameters(params)
          expect(update_mission.status).to eq("Failed")
          expect(status).to eq(nil)
        end
      end
    end
  end

  describe "#complete_mission" do
    subject(:completed_mission) { described_class.new(model) }

    let(:model) do
      {
        "name"      => "TestMission",
        "status"    => "In Progress",
        "latitude"  => 34.02,
        "longitude" => 12.23,
        "altitude"  => 60_700
      }
    end
    let(:status) { "Successful" }

    describe "When complete_mission is called and status is Successful" do
      it "adds an image key to the mission" do
        completed_mission.complete_mission(status)

        expect(completed_mission.image).to eq("dog-3.jpg")
      end
    end

    describe "When complete_mission is called and status is not Successful" do
      let(:status) { "Failed" }

      it "does not add an image key to the mission" do
        completed_mission.complete_mission(status)

        expect(completed_mission.image).to eq(nil)
      end
    end
  end
end
