# read data
uber_data <- read.csv("uber-raw-data-sep14.csv")

#include libraries

library(lubridate)
library(dplyr)
library(ggplot2)
library(ggmap)

########################################################################
# Heat map of Day of week with respect to hours

uber_data$Date <- mdy_hm(uber_data$Date, tz ="EST")
uber_data$day_of_week <- wday(uber_data$Date, label = TRUE)

# create a new column for the hour of the day
uber_data$hour_of_day <- hour(uber_data$Date)

#calculate the count of every hour with respect to day
count_hour_day <- uber_data %>%
  group_by(day_of_week, hour_of_day) %>%
  summarize(count = n())

# plot the heatmap using geom_tile()
ggplot(data = count_hour_day, aes(x = day_of_week, y = hour_of_day, fill = count)) +
  geom_tile(color= "black")+
  scale_fill_gradient(low = "white",high = "red")


########################################################################
## Google Maps

#register yourself
register_google(key = "ADD YOUR KEY HERE")
random_subset <- uber_data %>%
  sample_n(size = 300000)
#download map
map <- get_map(location = "NewYork")
ggmap(map) +
  geom_point(data = random_subset, aes(x = Lon, y = Lat), color = "red", alpha = 0.2)

########################################################################
## Bar chart of Uber pickups per hour

#calculate the count of every hour with respect to day
count_hour <- count_hour_day %>%
  group_by(hour_of_day) %>%
  summarize(sum = sum(count))


ggplot(count_hour, aes(x = hour_of_day, y = sum, fill = sum, color = "white")) +
  geom_bar(stat = "identity")+
  scale_fill_gradient (low ="dark red", high = "black")+
  labs(x = "Hours", y = "Count of Uber Pick-ups")

########################################################################
## Bar chart of Uber pickups per day
#calculate the count of every hour with respect to day

count_day <- count_hour_day %>%
  group_by(day_of_week) %>%
  summarize(sum = sum(count))
  
ggplot(count_day, aes(x = day_of_week, y = sum, fill = day_of_week)) +
  geom_bar(stat = "identity")+
  scale_fill_manual(values = c("deepskyblue3", "gold3", "darkorchid4", "darkolivegreen4", "darkgray", "brown4", "darksalmon")) +
  labs(x = "Days", y = "Count of Uber Pick-ups")
  
########################################################################

#calculate the count of every hour with respect to day
count_base_day <- uber_data %>%
  group_by(Base, day_of_week) %>%
  summarize(count = n())

ggplot(count_base_day, aes(x = Base, y = count, fill = day_of_week)) +
  geom_bar(stat = "identity", position = "dodge")+
  scale_fill_manual(values = c("deepskyblue3", "gold3", "darkorchid4", "darkolivegreen4", "darkgray", "brown4", "darksalmon"))
  

########################################################################
# Heat-map of date and hour
uber_data$date_of_month <- day(uber_data$Date)

#calculate the count of every hour with respect to date
count_hour_date <- uber_data %>%
  group_by(date_of_month, hour_of_day) %>%
  summarize(count = n())
dates <- c(1:30)
hours <- c(0:23)
# plot the heatmap using geom_tile()
ggplot(data = count_hour_date, aes(x = date_of_month, y = hour_of_day, fill = count)) +
  geom_tile(color= "black")+
  scale_fill_gradient(low = "white",high = "red")+
  labs(x="Date", y="Hours")+
  scale_x_continuous(breaks = dates, labels = dates)+
  scale_y_continuous(breaks= hours, labels = hours)

########################################################################
# Bar plot of date and count

count_date <- count_hour_date %>%
  group_by(date_of_month) %>%
  summarize(sum = sum(count))


ggplot(count_date, aes(x = date_of_month, y = sum, fill = sum, color = "white")) +
  geom_bar(stat = "identity")+
  scale_fill_gradient (low ="dark red", high = "black")+
  labs(x = "Date", y = "Count of Uber Pick-ups")+
  scale_x_continuous(breaks = dates, labels = dates)

#############################################################
# Check Classification
# Download map
map <- get_map(location = "NewYork")
# Map Facet Wraps for each base
ggmap(map) +
  geom_point(data = uber_data, aes(x = Lon, y = Lat), color = "red", alpha = 0.2)+
  facet_wrap(~Base)

# Base is not a good target variable w.r.t Longitude and Latitude

# Let's find if time is a good variable w.r.t Base
count_hour_day_wrt_base <- uber_data %>%
  group_by(Base, hour_of_day) %>%
  summarize(count = n())
# plot the Heatmap using geom_tile()
ggplot(data = count_hour_day_wrt_base, aes(x = Base, y = hour_of_day, fill = count)) +
  geom_tile(color= "black")+
  scale_fill_gradient(low = "white",high = "red")+
  labs(x= "Base", y = "Hours")+
  scale_y_continuous(breaks= hours, labels = hours)+
  ggtitle("Heatmap of Uber pickups in hours with respect to Base")

# The data is also distributed and scattered in a plain trend that shows no pattern
# thus it can't be a good metric for target variable

# Lets find out if there is a Geo-location trend with respect to time
# Map Facet Wraps for each hour
ggmap(map) +
  geom_point(data = uber_data, aes(x = Lon, y = Lat),color = "red", alpha = 0.2)+
  facet_wrap(~hour_of_day)


# Classification of geo-location wrt to hours and weekdays
# 4 variables classification mapping
ggmap(map) +
  geom_point(data = uber_data, aes(x = Lon, y = Lat, color = day_of_week), alpha = 0.2)+
  facet_wrap(~hour_of_day)
