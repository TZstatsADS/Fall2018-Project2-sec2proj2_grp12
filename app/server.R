library(shiny)
options(shiny.sanitize.errors = FALSE)

flightData <- read.table(file = "../output/1990.csv",
                         as.is = T, header = T,sep = ",")
flightData$FL_DATE <- parse_date_time(flightData$FL_DATE, "%Y-%m-%d")
flightData <- flightData[flightData$ORIGIN == c("JFK", "LAX", "SEA"),]

temp <-  read.csv("../output/temp.csv",header=T)
raw_data <-  read.csv("../output/flight_data.csv")
dataformap <- read.csv("../output/DataforMap.csv")

shinyServer(function(input, output) {
  
  
  ####Jiaqian Yu
  output$map23 <- renderLeaflet({
    
    flight_path(dataformap,o=input$Departure,distance1=input$distance[1],distance2=input$distance[2],
                price1=input$price[1],price2=input$price[2],choice=input$decision)
  })
  
  #output$delay_barplot <- renderPlotly({delay_barplot(temp,t=input$type,m=input$month,w=input$week,d=input$destination,o=input$origin)})
  
  #filtered_data = reactive({filter_data(raw_data,origin=input$origin1,destination=input$destination1)})
  #output$text <- renderPrint({'what about go to '+flight_path(dataformap,o=input$Departure,distance1=input$distance[1],distance2=input$distance[2],
  #                                                            price1=input$price[1],price2=input$price[2],delaytime1=input$delaytime[1],
  #                                                            delaytime2=input$delaytime[2],choice=input$decision)
  
  #### Jiaqian Yu
   
  filtered_data = reactive({filter_data(raw_data,origin=input$origin1,destination=input$destination1)})
  
  # Create Expected Delay Time by Airline Plot (Statistics section)
  output$plt_delay_time = renderPlotly(plot_delay_time(filtered_data=filtered_data(),
                                                       origin=input$origin1, 
                                                       destination = input$destination1))

  # Create Delayed Flight Distribution (Statistics section)
  output$plt_delay_flight_distr = renderPlotly(plot_delayed_flight_distribution(filtered_data=filtered_data(),
                                                                                origin=input$origin1, 
                                                                                destination = input$destination1))
  
  # Create Delay Time Stacked Barplot (Statistics section)
  output$plt_delay_time_distr = renderPlotly(plot_delay_time_distribution(filtered_data=filtered_data(),
                                                                          origin=input$origin1, 
                                                                          destination = input$destination1))
  
  # Create Delay Reason Stacked Barplot (Statistics section)
  filtered_data_delay_reason = reactive({filter_data(raw_data,
                                                     origin=input$origin2,
                                                     destination=input$destination2,
                                                     month=input$month2)})
  output$plt_delay_rank = renderPlotly(plot_delay_ranking(filtered_data=filtered_data_delay_reason(),
                                                                              origin=input$origin2,
                                                                              destination=input$destination2,
                                                                              month = input$month2))

  output$plt_delay_reason_distr = renderPlotly(plot_delay_reason_distribution(filtered_data=filtered_data_delay_reason(),
                                                                              origin=input$origin2,
                                                                              destination=input$destination2,
                                                                              month = input$month2))

  

})
