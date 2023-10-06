## Date created

September 2023

## Project Title

Hotel Promotion Optimization

## Description

In this R analytics project, I aim to provide valuable insights for a stakeholder in the hospitality industry looking to optimize their marketing strategy. Our analysis delves into hotel bookings data, specifically focusing on lead times and guests traveling with children.

## Key Features

1. Data Import: Data is imported from a CSV file using the read.csv function.
2. Installing and loading libraries: Packages such as ggplot2, tidyverse, and dplyr are installed and loaded to access various functions and visualization tools.
3. Exploratory Data Analysis (EDA):
* Scatter Plot (1): A scatter plot is created using ggplot2 to visualize the relationship between lead time and the number of children accompanying guests, providing insights into how booking lead time correlates with the presence of children.
* Bar Chart: A bar chart is generated to compare market segments by hotel type, helping identify which market segments generate the most bookings and where these bookings occur (city hotels or resort hotels).
* Faceting a Plot: Separate plots are created for each unique market segment to address the issue of comparing dimensions in the bar chart more accurately.
* Filtering Data: The filter() function is used to extract information specifically related to the correlation between lead time and guests with children, focusing on the dataset of City Hotel and Online Travel Agency (TA).
* Scatter Plot (2): Another scatter plot is generated to illustrate the relationship between lead time and the number of children at City Hotel via Online TA, helping determine the specific timing for the family-friendly promotion.

4. Conclusion: The analysis and visualizations provide key insights for the hotel manager. The project concludes by highlighting that promotions targeting families can be strategically timed closer to booking dates, especially for bookings involving multiple children.

## Required Packages
* library(ggplot2)
* library(tidyverse)
* library(dplyr)

## Files

* hotel_bookings.csv
* Hotel Booking.Rmd
* Hotel-Booking.html

## Copyright, Authors, Acknowledgements

I would like to thank Coursera for giving me the opportunity to learn and develop my R Programming skills.
