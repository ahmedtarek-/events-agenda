# README

## Intro
The application is divided into several modules:
1. Web Scraper that parses Gorki and CO websites (personal favorites)
2. A Job that is controlled by Clockwork and communicates with the scrapper to fetch data and stores them
3. Database layer that stores the scraped data
4. Web interfact that communicates with this database to view the agenda online

## Usage
1. Clone
2. bundle install
3. run ```clockwork clock.rb``` (to run the cronjob that updates the events agenda)

## Versions
* Ruby: 2.5.0
* Rails: 5.2
* Database: Sqlite3 (for simple deployment)

## Database
* used Sqlite3 for simplicity
* basic id (not uuid)

## Models
* One Event model that encapsulates all info collected for agenda
