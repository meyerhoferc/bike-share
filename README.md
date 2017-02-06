# Bike Share

## Abstract

In this project we used Ruby, Sinatra, and ActiveRecord to build a web application that analyzes bike share usage in San Francisco using this [data](https://www.kaggle.com/benhamner/sf-bay-area-bike-share). The project structured is centered on the Model, View, Controller (MVC) concept.

This application collects data in two ways: 1) through web forms allowing users to enter trip/station/weather information, and 2) by consuming CSV files with historical information for stations, trips, and weather. In addition to creating and storing this information for viewing at a later date, this application provides a number of user dashboards with higher level analysis of trends in bike share usage.

* Iteration 1: Allow users to save and view information related to bike share stations.
* Iteration 2: Create a seed file to consume information on the seventy existing bike share stations in San Francisco.
* Iteration 3: Create a station dashboard with analysis of station information (split by city, date installed, number of of bicycle docks)
* Iteration 4: Allow users to save and view information related to trips taken.
* Iteration 5: Update the seed file to consume information on the nearly 670,000 trips taken between August 29, 2013, and August 81, 2015.
* Iteration 6: Add information to the station dashboard using trip information, and create a trip dashboard with an analysis of trips taken.
* Iteration 7: Allow users to enter weather information.
* Iteration 8: Update the seed file to consume weather information.
* Iteration 9: Create a weather dashboard and update the trip dashboard with additional analytics regarding the relationship between weather and trips taken.

### ActiveRecord

We used ActiveRecord migrations, queries, and methods to create and interact with our database. ActiveRecord migrations created a normalized database, and all tables in the database were structured as 2NF or 3NF. ActiveRecord queries and relationships were implemented to calculate and report on information in the database.

### User Experience and Conventions

We used Sinatra and ERB templates to render views to create, read, update, and delete resources using restful routes and appropriate HTTP verbs. The dashboard views display information and analytics not related to a specific resource saved in the database. For styling, we used Materialize to create a user experience that allows users to comfortably navigate the site.

### Testing

We used RSpec and Capybara to drive development at the feature and model levels.
