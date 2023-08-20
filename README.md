# Farewell Not

Farewell Not was designed to allow users to send loved ones messages in the unfortunate event of their loss. This application will search online obituaries and based on a users name and birthday, will check if they are deceased. If so, a message they have created will send out to its respective recipients.

## Requirements

- Ruby 2.7.4
- NodeJS (v16), and npm
- Postgresql

## Installation

Clone the repository from Github (https://github.com/kmac303/farewell-not)
Then run these commands to set up everything:
- bundle install
- rails db:create
- npm install --prefix client

Once set up, run these commands in separate terminal windows to run the application:
- rails s: run the backend on http://localhost:3000
- npm start --prefix client: run the frontend on http://localhost:4000

## Usage

Begin by creating a User account through the Signup link. Once all your information is entered, you can create Messages to send to your loved ones. You can create multiple messages, with multiple recipients for each.

## Contributing

Signup for an account or Login to be able to contribute to this application. 

## License

Created by Kevin McIntosh for the Flatiron School Software Engineer Flex Program Phase 5 Project.

## Creation

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Content

Default background image for this application sourced from:
- imgix