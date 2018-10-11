

# flight_path <- function(data,m,o,d){
#   if(d=='all'){
#     df <- filter(data,month==m,orig==o)
#   }
#   else{
#     df <- filter(data,month==m,orig==o,dest==d)
#   }
#   
#   gcIntermediate(df[,c("Longitude_orig","Latitude_orig")],
#                  df[,c("Longitude_dest","Latitude_dest")],
#                  n=50, 
#                  addStartEnd=TRUE,
#                  sp=TRUE) %>% 
#     leaflet() %>% 
#     setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
#     addTiles() %>% 
#     addProviderTiles(providers$Stamen.TonerLite) %>% 
#     addPolylines(weight=2,color = 'orange')
#                     
#     
#     #%>% 
#     #addMarkers(data=df[,c("Longitude_orig","Latitude_orig")],
#                #lng = ~Longitude_orig, lat = ~Latitude_orig)
#     
# }




flight_path <- function(data,o,distance1,distance2,price1,price2,delaytime1,delaytime2,choice){
#  if(d=='all'){
#    if(w=='all'){
#      df <- filter(data,month==m,orig==o)
#    }else{
#      df <- filter(data,month==m,weekday==w,orig==o)
#    }
  if (choice=="No,I am still choosing.."){
    if (o=="All"){
      df <- data
      
  
      leaflet() %>%
      setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.DarkMatter) %>%   # # Stamen.TonerLite
      addMarkers(unique(df[,"OrLon"]),unique(df[,"OrLat"]),
                 icon=list(iconUrl='./icon/plane_2.png',iconSize=c(20,20)),
                 popup = df[,'ORIGIN_CITY'])
    }
  else{
   df1 <- filter(data,ORIGIN_CITY==o)
   df2 <- filter(df1,Dist>=distance1 & Dist<=distance2,
                 Average_Price>=price1 & Average_Price<=price2)
    leaflet() %>%
      setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.DarkMatter) %>%   # # Stamen.TonerLite
      addMarkers(unique(df2[,"OrLon"]),unique(df2[,"OrLat"]),
                 icon=list(iconUrl='./icon/plane_1.png',iconSize=c(20,20)),
                 #colours = "red",
                 popup = df1[,'ORIGIN_CITY'])%>%
     addMarkers(df2[,"DeLon"],df2[,"DeLat"],
                                icon=list(iconUrl='./icon/plane_2.png',iconSize=c(20,20)),
                                popup = df2[,'DEST_CITY'])
    #location <- "anywhere"
  }
    }
    else{
      df1 <- filter(data,ORIGIN_CITY==o)
        
      df2 <- filter(df1,ORIGIN_CITY==o,Dist>=distance1 & Dist<=distance2,
                    Average_Price>=price1 & Average_Price<=price2)
      df3 <- df2[sample(1:nrow(df2),size=1),]
      
      leaflet() %>%
        setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
        addTiles() %>%
        addProviderTiles(providers$CartoDB.DarkMatter) %>%   # # Stamen.TonerLite
        
       addMarkers(df3$OrLon,df3$OrLat,
                   icon=list(iconUrl='./icon/plane_1.png',iconSize=c(20,20)),
                   popup = df3$ORIGIN_CITY) %>% 
        addMarkers(df3$DeLon,df3$DeLat,
                   icon=list(iconUrl='./icon/plane_2.png',iconSize=c(20,20)),
                   popup = df3$DEST_CITY)
      #location <- df3$DEST_CITY
      
    }
   
  #return(location)
}
      
    
      
  #lng = ~Longitude_orig, lat = ~Latitude_orig)

    


#, popup = ~as.character(orig), label = ~as.character(orig)

#flight_path(temp,'Jul','JFK (New York, NY)','LAX (Los Angeles, CA)')

# 'LAX (Los Angeles, CA)'
# 
# x <- seq(0,1,0.1)
# plot(x,x,col=cc)
# 
# cc <- color.scale(x,cs1=c(0,1),cs2=c(0,1),cs3=c(0,1),alpha=1,
#             extremes=NA,na.color=NA,xrange=NULL,color.spec="rgb")
# cc
# 
# cc <- heat.colors(11, alpha = 1)
# 
# colfunc <- colorRampPalette(c("white","red"))
# colfunc(10)
# plot(rep(1,10),col=colorRampPalette(c("white","red"))(10),pch=19,cex=3)




