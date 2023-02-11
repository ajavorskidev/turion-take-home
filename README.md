# Turion Space Take Home Missions API

The Missions API allows users to get a list of missions, get an individual mission, create missions, update missions, destroy missions, and fetch images from an AWS S3 bucket if a mission is completed.

## Getting started
  This API is built and compatible with Ruby 3.0.0 and Rails 7+. Please ensure before using the API, to switch to the correct versions of both Ruby and Rails to ensure functionality.
  

 ### Setup
After cloning the API repository, run the following commands to set up the API:
Install the required Gems by running: 
````
bundle install
````
Then run the database migration:
 ````
 bin/rails db:migrate
 ````
 Once the migration was ran successfully, ensure to seed the database with:
 ````
 bin/rails db:seed
 ````  
 **IMPORTANT**:
Ensure that the AWS credentials and Devise key are populated in the `credentials.yml.enc` file. This can be done by running:
`````
bin/rails credentials:edit
`````
If an Editor is not defined, you may need to run:
````ini
EDITOR="nano --wait" bin/rails credentials:edit
````
After running `bundle install` , database migrations, and populating `credentials.yml.enc`
you may start the Rails API by running:
````
bin/rails server
````
## Available API Routes
All routes except the authentication routes, require populating the authorization header for each request. If using postman, you may use `basic auth` to populate user credentials for the request.
### Authentication Route
|Action|Route|Required Body |Description |
|--|--|--|--|
|POST  |/api/users/  |{"email": "string", "password": "string"}  | Devise route to allow for the creation of a user account.
### Mission Routes 
|Action|Route|Required Body |Description |
|--|--|--|--|
|GET  |/api/missions/  |None  |Route to list all missions for the current user.  |
|GET |/api/missions/:id |None |Route to list a mission corresponding to the mission id. |
|POST |/api/missions/ |{"name": "string", "latitude": double, "longitude": double, "altitude": integer }  |Route to create a mission. The request body should include the mission name, and the location parameters of the object (latitude, longitude, and altitude). The status of the mission will by default start as "Planned" |
|PUT |/api/missions/:id |{"name": "string", "status": ["Planned", "In Progress", "Successful", "Failed"], "latitude": double, "longitude": double, "altitude": integer } |Route to update a mission corresponding to mission id. Successful updating of a mission will result in a `200 Success` response. If the status of the mission is not "Planned", only "status" may be updated, and will result in a `400 Bad Request` response if given other parameters. |
|DELETE|/api/missions/:id|None|Route to destroy the mission corresponding to the mission id. Successful deletion of a mission will result in a 200 empty response.|
### Image Route
If a mission status is set to complete, an image is available to be fetched from the AWS S3 bucket.
|Action|Route| Required Body | Description
|--|--|--|--|
|GET  |/api/images/:id  | None | Route to fetch an image corresponding to a completed mission's id.
