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
      
