oridata1 <- read.csv("../output/delay_rating_fare_safety_RS.csv")
oridata2 <- read.csv("../output/Final_Data.csv")


library(dplyr)
library(geosphere)
data1<-oridata1 %>% 
  select(ORIGIN_CITY,DEST_CITY,Carrier,Average_Delay_Time,Average_Price,Food_Drink,Entertainment,Seat_comfort,Stuff_Service,Value_for_Money) %>%
  group_by(ORIGIN_CITY,DEST_CITY,Carrier) %>%
  summarise(Average_Delay_Time=mean(Average_Delay_Time),Average_Price=mean(Average_Price),
            Food_Drink=mean(Food_Drink),Entertainment=mean(Entertainment),
            Seat_comfort=mean(Seat_comfort),Stuff_Service=mean(Stuff_Service),Value_for_Money=mean(Value_for_Money))
nrow(data1)


oridata2$OriginCity <- str_sub(oridata2$OriginCity,1,-5)
oridata2$DestCity <- str_sub(oridata2$DestCity,1,-5)

a <- unique(data1$ORIGIN_CITY)
b <- unique(oridata2$DestCity)
af <- a[is.element(a,b)]
af
data1 <- data1[is.element(data1$ORIGIN_CITY,af),]
data1 <- data1[is.element(data1$DEST_CITY,af),]


oridata2 <-oridata2[is.element(oridata2$DestCity,af),] 
OrLon <- rep(0,nrow(data1))
for (i in 1:nrow(data1)){
  OrLon[i] <- oridata2$DestLon[oridata2$DestCity==data1$ORIGIN_CITY[i]][1]
}
OrLat <- rep(0,nrow(data1))
for (i in 1:nrow(data1)){
  OrLat[i] <- oridata2$DestLat[oridata2$DestCity==data1$ORIGIN_CITY[i]][1]
}
DeLon <- rep(0,nrow(data1))
for (i in 1:nrow(data1)){
  DeLon[i] <- oridata2$DestLon[oridata2$DestCity==data1$DEST_CITY[i]][1]
}
DeLat <- rep(0,nrow(data1))
for (i in 1:nrow(data1)){
  DeLat[i] <- oridata2$DestLat[oridata2$DestCity==data1$DEST_CITY[i]][1]
}
data1$OrLon <- OrLon
data1$OrLat <- OrLat
data1$DeLon <- DeLon
data1$DeLat <- DeLat


Dist <- rep(0,nrow(data1))
for (i in 1:nrow(data1)){
  Dist[i] <-distm(c(data1$OrLon[i],data1$OrLat[i]),c(data1$DeLon[i],data1$DeLat[i]),fun=distGeo)/1000
}

data1$Dist <- Dist


write.csv(data1,"../output/DataforMap.csv")
