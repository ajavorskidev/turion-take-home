Mission.destroy_all
User.destroy_all

Mission.create(name: "IBM001", status: "Planned", latitude: 35.03, longitude: 19.12,
               altitude: 60_500, email: "ibmuser@ibm.com")
Mission.create(name: "IBM002", status: "Planned", latitude: 31.65, longitude: 52.43,
               altitude: 96_50, email: "ibmuser@ibm.com")
Mission.create(name: "IBM003", status: "In Progress", latitude: 31.65, longitude: 52.43,
               altitude: 96_500, email: "ibmuser@ibm.com")
Mission.create(name: "IBM004", status: "Successful", latitude: 37.24, longitude: 82.03,
               altitude: 54_000, email: "ibmuser@ibm.com", image: "dog-3.jpg")
Mission.create(name: "IBM005", status: "Failed", latitude: 35.43, longitude: 52.23,
               altitude: 90_500, email: "ibmuser@ibm.com")
Mission.create(name: "IBM006", status: "Planned", latitude: 35.03, longitude: 19.12,
               altitude: 60_500, email: "ibmuser@ibm.com")
Mission.create(name: "IBM007", status: "In Progress", latitude: 31.65, longitude: 52.43,
               altitude: 96_500, email: "ibmuser@ibm.com")
Mission.create(name: "IBM008", status: "In Progress", latitude: 31.65, longitude: 52.43,
               altitude: 96_500, email: "ibmuser@ibm.com")
Mission.create(name: "USS001", status: "Successful", latitude: 37.24, longitude: 82.03,
               altitude: 54_000, email: "govuser@gov.com", image: "cat-3.jpg")
Mission.create(name: "USS002", status: "Failed", latitude: 35.43, longitude: 52.23,
               altitude: 90_500, email: "govuser@gov.com")
Mission.create(name: "USS003", status: "Planned", latitude: 35.03, longitude: 19.12,
               altitude: 60_500, email: "govuser@gov.com")
Mission.create(name: "USS004", status: "In Progress", latitude: 31.65, longitude: 52.43,
               altitude: 96_500, email: "govuser@gov.com")
Mission.create(name: "USS005", status: "In Progress", latitude: 31.65, longitude: 52.43,
               altitude: 96_500, email: "govuser@gov.com")
Mission.create(name: "AMD001", status: "Successful", latitude: 37.24, longitude: 82.03,
               altitude: 54_000, email: "amduser@amd.com", image: "dog-1.jpg")
Mission.create(name: "AMD002", status: "Failed", latitude: 35.43, longitude: 52.23,
               altitude: 90_500, email: "amduser@amd.com")

User.create! email: "ibmuser@ibm.com", password: "test_password1",
             password_confirmation: "test_password1"
User.create! email: "govuser@gov.com", password: "test_password2",
             password_confirmation: "test_password2"
User.create! email: "amduser@amd.com", password: "test_password3",
             password_confirmation: "test_password3"
