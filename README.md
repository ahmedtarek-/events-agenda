# README

## Visit the app
https://rene-events-agenda.herokuapp.com/

## Intro
The main idea was to implement independant modules for ease of scalability for each module (and each can be extracted in the future into a microservice). Hence the application is divided into these modules:
1. Web Scraper that parses Gorki and CO websites (personal favorites)
2. A Job that is controlled by Clockwork and communicates with the scrapper to fetch data and stores them
3. Database layer that stores the scraped data
4. Web interface that communicates with this database to view the agenda online

## Usage
1. Clone
2. bundle install
3. run ```clockwork clock.rb``` (to run the cronjob that updates the events agenda)

## Versions
* Ruby: 2.5.0
* Rails: 5.2
* Database: Postgres (for simple deployment)

## Improvements
1. Only implemented model tests.
2. Add tests for the scraper module and the cron job

## Database
* used Sqlite3 for simplicity at first but then migrated to Postgres to deploy to heroku
* basic id (not uuid)

## Models
* One Event model that encapsulates all info collected for agenda
