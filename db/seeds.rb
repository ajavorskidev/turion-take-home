Mission.destroy_all

Mission.create(name: "IBM001", status: "Planned", latitude: 35.03, longitude: 19.12,
               altitude: 60_500)
Mission.create(name: "IBM002", status: "In Progress", latitude: 31.65, longitude: 52.43,
               altitude: 96_500)
Mission.create(name: "USS001", status: "Successful", latitude: 37.24, longitude: 82.03,
               altitude: 54_000)
Mission.create(name: "USS002", status: "Failed", latitude: 35.43, longitude: 52.23,
               altitude: 90_500)
