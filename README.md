# README

## Intro
The website has 3 main parts:
1. Web Scraper that continuosly parses Gorki and CO websites (personal favorites)
2. Database layer that stores the scraped data
3. Web app that interacts with this database to view the agenda online

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
