# Project 2: Flight Delay Analysis Shiny App

You are welcomed to visit our APP......

## Team members
- Yang Yang
- Jiaqian Yu
- Tao Han

## Project summary
This is a travel app.

The purpose of this app is to aid travelers in choosing a destination, a month to travel and a best flight based on various crtieria, such as distance, price and delay time.

We offer the following services:

Choose Destination: A destination suggestion based on your departure city and desired distance and price.
We will provide a random destination(of course, sampled by some probabilities) that follows all your request for you.
Choose Months and Carriers: A month and carrier suggestion based on delay time.
Delay Time Expectation:
Expected Flight Delay Time in Minutes: shows expected number of minutes you can expect a given flight to be delayed for a given carrier in a given month
Number of Delayed Flights: shows the number of delayed flights a given carrier had in each month (sense of scale)
Delay Time Distribution: shows distribution of delay time for a given flight by carrier
Delay Reason:
Delay Reason Distribution: shows distribution of delay reasons for a given flight and month by carrier

## Contribution statement

Yang Yang contributes to data collection and a dynamic html page.

Jiaqian Yu contributes to data cleaning, the Tab "Choose Destination" and all the intergration part.

Tao Han contributes to data preprocessing and the Tab "Choose Months and Carriers".



## Data Source
+ [data.gov](https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time)
+ [openflights.org](https:/openflights.org/data.html)


------------------------------------------------------------------------
Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── app/
├── lib/
├── data/
├── doc/
└── output/
```

Please see each subfolder for a README file.

