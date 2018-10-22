# packages.used <- 
#   c("ggplot2",
#     "plyr",
#     "reshape2",
#     "reshape",
#     "shiny",
#     "dplyr",
#     "lubridate",
#     "zoo",
#     "treemap",
#     "plotly",
#     "leaflet",
#     "geosphere",
#     "shinydashboard",
#     "ROCR",
#     "sparklyr",
#     "DT"
# 
#   )
# 
# # check packages that need to be installed.
# packages.needed=setdiff(packages.used, 
#                         intersect(installed.packages()[,1], 
#                                   packages.used))
# # install additional packages
# if(length(packages.needed)>0){
#   install.packages(packages.needed, dependencies = TRUE)
# }

#load the packages
library(ggplot2)
library(zoo)
library(lubridate)
library(dplyr)
library(shiny)
library(shinydashboard)
library(treemap)
library(plotly)
library(reshape2)
library(leaflet)
library(geosphere)
library(ROCR)
library(DT)
library(sparklyr)


source("plot_functions.R")
source("filter_data_functions.R")

source("flight_path_map_new.R")


raw_data = read.csv("flight_data.csv")
dest_airport=c('All',as.character(sort(unique(raw_data$dest))))
orig_airport=c('All',as.character(sort(unique(raw_data$orig))))


dataformap <- read.csv("DataforMap.csv")

file_content <- function(file) {
  return(readChar(file, file.info(file)$size))
}

#Define UI for application that draws a histogram
shinyUI(navbarPage(theme = "bootstrap.min-copy.css",'Flight For Travelers',
        tabPanel("Introduction",
                 tabName="Introduction",
                 icon=icon("book"),
                 #menuItem("Overview",tabName="Overview",icon=icon("book")),
                 
                 mainPanel(
                   img(src="world_flight.jpg",height='300',width='600'),
                   h2('Introduction'),
                   includeMarkdown('intro.md')
                   )
                 # titlePanel(h2("Introduction")),
                 # mainPanel(tabPanel("Introduction"))
        ),

        tabPanel('Choose Destination',
                 tabName='Choose your destination',
                 icon=icon('plane'),
                 sidebarLayout(
                   sidebarPanel(
                     
                     selectInput(inputId = "Departure",
                                 label  = "Select your city",
                                 choices = c("All",as.character(unique(dataformap$ORIGIN_CITY))),
                                 selected ='All'),
                     sliderInput(inputId = "distance", label = h3("Select the distance"), min = 100, 
                                 max = 8000, value = c(100,8000)),
                     sliderInput(inputId = "price", label = h3("Select the price"), min = 5, 
                                 max = 800, value = c(5,800)),
                     radioButtons(inputId = "decision", 
                                  label = "Ready to see the result?",
                                  choices = c('Yes!','No,I am still choosing..'), 
                                  selected = 'No,I am still choosing..')
                     
                     
                     
                     
                   ),
                   mainPanel(
                     box(leafletOutput("map23"),
                         width=600)
                     #box(textOutput("text"),width=300)
                   )
                 )
                 
                 
                 ######## Jiaqian Yu
                 
                 
        ),
        
        tabPanel('Choose Months and Companies',
                 tabName='App',
                 icon=icon('bar-chart'),
                 tabsetPanel(type="pill",
                             tabPanel('Delay Time',
                                      sidebarLayout(
                                        sidebarPanel(
                                          
                                          selectInput(inputId = "destination1",
                                                      label  = "Select the Destination",
                                                      choices = dest_airport,
                                                      selected ='All'),
                                          selectInput(inputId = "origin1",
                                                      label  = "Select the Origin",
                                                      choices = orig_airport,
                                                      selected ='All'),
                                          width = 3
                                        ),
                                        
                                        mainPanel(
                                          box(plotlyOutput("plt_delay_time"),width=300),
                                          box(plotlyOutput("plt_delay_time_distr"),width=300)
                                        )
                                      )
                                      
                             ),
                             tabPanel('Delay Reason',
                                      sidebarLayout(
                                        sidebarPanel(
                                          
                                          selectInput(inputId = "destination2",
                                                      label  = "Select the Destination",
                                                      choices = dest_airport,
                                                      selected ='All'),
                                          selectInput(inputId = "origin2",
                                                      label  = "Select the Origin",
                                                      choices = orig_airport,
                                                      selected ='All'),
                                          selectInput(inputId = "month2",
                                                      label  = "Select the Month",
                                                      choices = c('Jan','Feb','Mar','Apr','May','Jun','Jul',
                                                                  'Aug','Sep','Oct','Nov','Dec'),
                                                      selected ='Jan'),
                                          width = 3
                                        ),
                                        
                                        mainPanel(
                                          box(plotlyOutput("plt_delay_rank"),width=300),
                                          box(plotlyOutput("plt_delay_reason_distr"),width=300)
                                        )
                                      )
                                      
                             )
                             
                 )
                 ),
        
        tabPanel('About Us',
                 tabName='About Us',
                 icon=icon('address-card-o'),
                 
                 box(includeMarkdown('contact.md')),
                 box(img(src="thank_you.png",height='300',width='400')))
        )
        )




