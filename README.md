# Farewell Not

Farewell Not was designed to allow users to send loved ones messages in the unfortunate event of their loss.

## Requirements

- Ruby 2.7.4
- NodeJS (v16), and npm
- Postgresql

## Installation

Clone the repository from Github (https://github.com/kmac303/phase-4-project)
Then run these commands to set up everything:
- bundle install
- rails db:create
- npm install --prefix client

Once set up, run these commands in separate terminal windows to run the application:
- rails s: run the backend on http://localhost:3000
- npm start --prefix client: run the frontend on http://localhost:4000

## Usage

Navigate through the application by viewing different restaurants in the database or search by restaurant info, and view their respective reviews by clicking on an individual restaurant. At the top of each individual restaurant page is an aggregate review, factoring in all reviews for that restaurant and assigning it an average star rating.

## Contributing

Signup for an account or Login to be able to contribute to the application. If you'd like to leave a review or add a restaurant, you can add your own by clicking on "Leave a Review" or "Add New Restaurant". If you want to edit or delete a review you left, you can do so by clicking the "Edit Your Review" or "Delete Your Review" buttons underneath that individual review.

## License

Created by Kevin McIntosh for the Flatiron School Software Engineer Flex Program Phase 4 Project.

## Creation

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Content

Default images used for the source files of this application are from:
- The Exchange District Biz
- TripAdvisor
- NJ.com
- Unsplash