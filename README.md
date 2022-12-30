# Uber-pickup-in-new-york-city
This repository is for data analysis on the data provided by Uber for September 2014 of Newyork pickups

The csv file 'uber-raw-data-sep14.csv' contains all the data of (1028136, 4) dimensions.
The file had 4 columns:
- `Date/Time` that represents the time stamp for the pickup
- `Lat` that represents the lattitude value of pickup
- `Lon` that represents the longitude value of pickup
- `Base` that represents the TLC base company assosiated with the ride

Complete Notebook is available on the following link: 
https://www.kaggle.com/syedbelall/uber-pickup-in-new-york-city

The Code is provided in a script.R file and the output is in a markdown uploaded on Kaggle 
Some of the few outputs are given here 
## Longitude and Latitude mapped on Google Maps 
![Google Maps](https://github.com/GoSleepBelall/Uber-pickup-in-new-york-city/blob/73e0aec908c139b76298af5b951d89afd5510882/images/google%20maps.png)

## Heatmap of Uber pickup with respect to Days and Hours
![Heatmap](https://github.com/GoSleepBelall/Uber-pickup-in-new-york-city/blob/73e0aec908c139b76298af5b951d89afd5510882/images/heatmap.png)

## Bar plot of count of uber calls each hour throught whole month
![Bar plot](https://github.com/GoSleepBelall/Uber-pickup-in-new-york-city/blob/0d79c6dfb7f55e06209f6cb48ff3c9ecc70d0702/images/hours%20plot.png)

## Geo-location of Uber calls with respect to each hour
![Google Maps](https://github.com/GoSleepBelall/Uber-pickup-in-new-york-city/blob/0d79c6dfb7f55e06209f6cb48ff3c9ecc70d0702/images/geo-location%20wrt%20hours.png)

## Summary:
- The number of pick-ups increase as the day progresses. 
- The number of pick-ups peaks around 6 pm when it is office leave time.
- The base B02617 is the best for Buisness perspective.
- The base B02512 is the worst for Buisness perspective.
- Tuesday have highest count of Uber Pickups
- Weekend shows highest number of pickups in nights.
- Maximum trend of uber pick-ups are in the center of city.
- Tuesday was the best day for all bases except B02764. It have Saturday as best day.
- 13th September had the most pick-ups
