require "rails_helper"

RSpec.describe MissionsController, type: :controller do
  let(:user_credentials) do
    {
      email:    "testuser@email.com",
      password: "test12345"
    }
  end

  let(:current_user) { User.create(user_credentials) }

  let(:id) { "1" }

  let(:mission_model) do
    {
      "name"      => "TestMission",
      "status"    => "Planned",
      "latitude"  => 34.02,
      "longitude" => 12.23,
      "altitude"  => 60_700,
      "email"     => "testuser@email.com",
      "image"     => "dog-3.jpg"
    }
  end

  let(:mission) { Mission.new(mission_model) }

  before do
    sign_in current_user
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe "#index" do
    let(:mission_list) do
      [mission, mission, mission]
    end

    describe "When the user has missions created" do
      before do
        allow(Mission).to receive(:where).with({ email: current_user.email })
                                         .and_return(mission_list)
      end

      it "returns an array of missions" do
        expect(controller).to receive(:render).with(json: mission_list)
        get :index
      end
    end
  end

  describe "#show" do
    describe "When the id parameter and user email are associated with a mission" do
      before do
        allow(Mission).to receive(:where).with({ id:    id,
                                                 email: current_user.email }).and_return([mission])
      end

      it "returns a mission" do
        expect(controller).to receive(:render).with(json: mission)
        get :show, params: { id: id }
      end
    end
  end

  describe "#create" do
    describe "When user provides valid parameters" do
      let(:expected_mission_model) do
        {
          "id":        1,
          "name":      "testMissionPOST",
          "status":    "Planned",
          "latitude":  23.43,
          "longitude": 34.21,
          "altitude":  40_000
        }
      end
      let(:expected_mission) { Mission.new(expected_mission_model) }

      it "creates a mission" do
        expect(controller).to receive(:render).with(json: expected_mission)
        post :create,
             params: { name: "testMissionPOST", latitude: 23.43, longitude: 34.21,
                       altitude: 40_000 }
      end
    end
  end

  describe "#update" do
    let(:mission) { Mission.new(mission_model) }
    let(:expected_mission) { Mission.new(expected_mission_model) }

    before do
      allow(Mission).to receive(:where).with({ id:    id,
                                               email: current_user.email }).and_return([mission])
    end

    describe "When a user provides valid parameters" do
      describe "for a mission with Planned status" do
        let(:params) do
          {
            id:       1,
            latitude: 10.12,
            mission:  {
              latitude: 10.12
            }
          }
        end
        let(:mission_model) do
          {
            "id":        1,
            "name":      "testMissionPUT",
            "status":    "Planned",
            "latitude":  23.43,
            "longitude": 34.21,
            "altitude":  40_000
          }
        end
        let(:expected_mission_model) do
          {
            "id":        1,
            "name":      "testMissionPUT",
            "status":    "Planned",
            "latitude":  10.12,
            "longitude": 34.21,
            "altitude":  40_000
          }
        end

        it "Renders the updated mission" do
          expect(controller).to receive(:render).with(json: expected_mission, status: nil)
          put :update, params: params
        end
      end

      describe "for a mission with a status other than Planned" do
        let(:params) do
          {
            id:      1,
            status:  "Failed",
            mission: {
              status: "Failed"
            }
          }
        end
        let(:mission_model) do
          {
            "id":        1,
            "name":      "testMissionPUT",
            "status":    "In Progress",
            "latitude":  23.43,
            "longitude": 34.21,
            "altitude":  40_000
          }
        end
        let(:expected_mission_model) do
          {
            "id":        1,
            "name":      "testMissionPUT",
            "status":    "Failed",
            "latitude":  10.12,
            "longitude": 34.21,
            "altitude":  40_000
          }
        end

        it "Renders the updated mission" do
          expect(controller).to receive(:render).with(json: expected_mission, status: nil)
          put :update, params: params
        end
      end
    end

    describe "When a user provides invalid parameters for a further progressed mission" do
      let(:params) do
        {
          id:       1,
          altitude: 67_000,
          mission:  {
            altitude: 67_000
          }
        }
      end
      let(:mission_model) do
        {
          "id":        1,
          "name":      "testMissionPUT",
          "status":    "In Progress",
          "latitude":  23.43,
          "longitude": 34.21,
          "altitude":  40_000
        }
      end
      let(:expected_mission_model) do
        {
          "id":        1,
          "name":      "testMissionPUT",
          "status":    "In Progress",
          "latitude":  10.12,
          "longitude": 34.21,
          "altitude":  40_000
        }
      end
      let(:status_code) { 400 }

      it "returns the unmodified mission and a status 400 Bad request response" do
        expect(controller).to receive(:render).with(json: expected_mission, status: status_code)
        put :update, params: params
      end
    end
  end

  describe "#destroy" do
    let(:mission_model) do
      {
        "name"      => "TestMission",
        "status"    => "Planned",
        "latitude"  => 34.02,
        "longitude" => 12.23,
        "altitude"  => 60_700,
        "email"     => "testuser@email.com",
        "image"     => "dog-3.jpg"
      }
    end

    let(:mission) { Mission.new(mission_model) }

    describe "User provided valid mission id" do
      before do
        allow(Mission).to receive(:where).with({ id:    id,
                                                 email: current_user.email }).and_return([mission])
      end

      it "destroys the mission and renders message" do
        expect(controller).to receive(:render).with(json:   "TestMission has been canceled",
                                                    status: :ok)
        delete :destroy, params: { id: id }
      end
    end

    describe "User provided invalid mission id" do
      it "returns a not found response" do
        expect(controller).to receive(:render).with(status: :not_found)
        delete :destroy, params: { id: id }
      end
    end
  end
end
