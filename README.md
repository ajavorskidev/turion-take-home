# Turion Space Take Home Missions API

The Missions API allows users to get a list of missions, get an individual mission, create missions, update missions, destroy missions, and fetch images from an AWS S3 bucket if a mission is completed.

**Approach to take home project's problem and expectations:**
After reading the requirements and expectations, I spent some time breaking down the requirements to understand what exactly needs to be done to satisfy each requirement (ie. One requirement being that a user should be able to check the state of a mission; which I broke down to being able to get the information associated to a specific mission). After breaking down each requirement, I thought of the different obstacles and barriers that may become present when implementing solutions for each requirement, such as the obstacles seen with attempting to implement "Devise", a popular user authentication gem for rails, with an API mode rails application. From this point, I spent a fair bit of time researching potential workarounds for any perceived issues (Such as finding the Devise-JWT extension for Devise, that would allow me to implement functionality without altering Devise too much) and planning out the stages of work that needed to be done; Implementing the base routes to fetch and manipulate missions, implementing a solution to grabbing images from the provided S3 bucket, implementing user authentication, and ensuring testing suites were present for the application. After planning out the development process that I would follow, I started with the implementation of the basic CRUD routes in the missions controller and ensuring that these routes functioned properly before continuing to implement fetching images. After the implementation of the basic routes, I created an images controller, which would be the main controller for invoking the AWS S3 service client to fetch images from the S3 bucket. I decided to use the approach of storing image-keys in the database, which could then be provided to the S3 service client's get_object method. After implementing fetching images from the bucket, I focused on limiting users to missions associated with their accounts by utilizing the Devise authentication gem. I spent some time working on setting up Devise, as the gem is not specifically developed with APIs in mind (Devise relies on sessions, which an API would have disabled). Though with some research, was able to disable session storage, and enable the utilization of an authorization header to allow users to authenticate themselves. Lastly, after the implementation of user authentication, I focused on rewriting the RSpec tests that I initially made to better test my implementation.

**Potential future improvements/expansions of the API/Solution:**
While I would like to think that the approach I took was the most optimal, I believe certain aspects of this API may be improved. For instance, my current implementation of the API only allows fetching images and not uploading images from an S3 bucket, though future changes could include the feature of uploading images (Which would be reasonable, considering the scope and purpose of the API in regards to obtaining and manipulating a mission's information). A second point of potential improvement would be the implementation of a predefined set of states that a mission could potentially be at; as my current implementation focuses on providing freedom in setting those states (ie. "Planned", "In Progress", "Successful", "Failed", etc.). Other potential expansions to this API may include a more customized user authentication implementation (Replacing Devise with a custom JWT strategy), allowing multiple images to be associated with a completed mission, or more complex expansions such as creating a solution to automatically update the latitude, longitude, and altitude of an imaging target; accounting for the change in location depending when an imaging request was placed (forgive my limited knowledge in tracking objects in orbit, though I assume that satellites or imaging targets are not always in a geosynchronous orbit).
## Getting started
  This API is built and compatible with Ruby 3.0.0 and Rails 7+. Please ensure before using the API, to switch to the correct versions of both Ruby and Rails to ensure functionality.
  

 ### Setup
After cloning the API repository, run the following commands to set up the API:
 **IMPORTANT**:
Create a `master.key` file in the `config` folder, and populate it with the given master.key. If you skip this step, you will be unable to read
or edit the `credentials.yml.enc` file.

Ensure that the AWS credentials and Devise key are populated in the `credentials.yml.enc` file. This can be done by running:
`````
bin/rails credentials:edit
`````
If an Editor is not defined, you may need to run:
````ini
EDITOR="nano --wait" bin/rails credentials:edit
````

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

After running `bundle install` , database migrations, and populating `credentials.yml.enc`
you may start the Rails API by running:
````
bin/rails server
````
 ### Testing
 A RSpec test suite has been implemented for this project. Any further additions to the suite can be tested by running:
 ````
 rspec
 ````
 or, if attempting to test a specific file:
 ````
 rspec ./spec/{controller/model/etc}/filename_spec.rb
 ````
 Rubocop is also included in this project, for linting and format checking, you may run:
 ```
 rubocop
 ```
## Available API Routes
All routes require populating the authorization header for each request. If using postman, you may use `basic auth` to populate user credentials for the request, and if implementing into an existing application you may populate the JWT provided as a bearer token from the sign_in response authorization header.
### Authentication Route
|Action|Route|Required Body |Description |
|--|--|--|--|
|POST  |/api/users/  |{"user": { email": "string", "password": "string" } }  | Devise route to allow for the creation of a user account. User will remain signed-in, and must be logged out to test other users.|
|POST|/api/users/sign_in|None| Devise route to allow for a user to sign in. Used to create a JWT token found in the response's authorization header.|
|DELETE|/api/users/sign_out|None| Devise route to revoke token generated from sign_in or sign_up. Requires bearer token to be passed in authorization header.|
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
