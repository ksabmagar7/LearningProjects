library(readr)
library(ggplot2)
library(ggpubr) 

S2 <- read_csv("data/S2img_.csv"); 
View(S2)
colnames(S2) <- c('n','S2ndvi')
S2 <- S2[-3]
nrow(S2)

L8_21 <- read_csv("data/L8img21_.csv")
colnames(L8_21) <- c('n','L8ndvi21')
L8_21 <- L8_21[-3]
nrow(L8_21)

L7 <- read_csv("data/L7img_.csv")
colnames(L7) <- c('n','L7ndvi')
L7 <- L7[-3]
nrow(L7)

S2_21<- read_csv("data/S2img21_.csv")
colnames(S2_21) <- c('n','S2ndvi21')
S2_21 <- S2_21[-3]
nrow(S2_21)


L8 <- read_csv("data/L8img_.csv")
colnames(L8) <- c('n','L8ndvi')
L8 <- L8[-3]
nrow(L8)


L9_21 <- read_csv("data/L9img21_.csv")
colnames(L9_21) <- c('n','L9ndvi21')
L9_21 <- L9_21[-3]
nrow(L9_21)

?plot
# L7 and L8
par(mfrow=c(3,3))
L8_L7_ndvi <- merge(L8, L7, by = 'n'); View(L8_L7_ndvi)
a <- plot(L8_L7_ndvi$L8ndvi, L8_L7_ndvi$L7ndvi, cex = .5, lwd=0.25,
          xlab="L8", ylab="L7")
cor(L8_L7_ndvi$L8ndvi, L8_L7_ndvi$L7ndvi)

# S2 and L8
S2_L8_ndvi <- merge(S2, L8, by = 'n')
b <- plot(S2_L8_ndvi$S2ndvi, S2_L8_ndvi$L8ndvi, cex = .5, lwd=0.25,
          xlab="S2", ylab="L8")
cor(S2_L8_ndvi$S2ndvi, S2_L8_ndvi$L8ndvi)

# S2 and L7
S2_L7_ndvi <- merge(S2, L7, by ='n')
c <- plot(S2_L7_ndvi$S2ndvi, S2_L7_ndvi$L7ndvi, cex =.5, lwd=0.25,
          xlab="S2", ylab="L7")
cor(S2_L7_ndvi$S2ndvi, S2_L7_ndvi$L7ndvi)

# S2 and L8, ndvi 2021
S2_L8_ndvi21 <- merge(S2_21, L8_21, by = 'n')
d <- plot(S2_L8_ndvi21$S2ndvi21, S2_L8_ndvi21$L8ndvi21, cex=.5, lwd=0.25,
          xlab="S2 - 2021", ylab="L8 - 2021")
plot(S2_L8_ndvi21$S2ndvi21, S2_L8_ndvi21$L8ndvi21)

# S2 and L9, ndvi 2021
S2_L9_ndvi21 <- merge(S2_21, L9_21, by = 'n')
e <- plot(S2_L9_ndvi21$S2ndvi21, S2_L9_ndvi21$L9ndvi21, cex=.5, lwd=0.25,
          xlab="S2 - 2021", ylab="L8 - 2021")
cor(S2_L9_ndvi21$S2ndvi21, S2_L9_ndvi21$L9ndvi21)

# L9 and L8, ndvi 2021
L9_L8_ndvi21 <- merge(L9_21, L8_21,by = 'n')
f <- plot(L9_L8_ndvi21$L9ndvi21, L9_L8_ndvi21$L8ndvi21,cex=.5, lwd=0.25,
          xlab="S2 - 2021", ylab="L8 - 2021")
cor(L9_L8_ndvi21$L9ndvi21, L9_L8_ndvi21$L8ndvi21)


library(ggplot2); library(jtools)
## example
plot <- ggplot(mpg, aes(cty, hwy)) +
  geom_jitter()
plot + theme_apa()

# Plot
plt1 = ggplot(S2_L9_ndvi21, aes(x = S2ndvi21, y = L9ndvi21)) +
  geom_point(color = 'green', size=2, alpha = .01)+
  xlim(0, 0.8) +   
  ylim(0, 0.8) +
  ggtitle("Year 2021") +
  labs(y = "Sentinel 2", x = "Landsat 9")+
  stat_cor(method = "pearson", label.x = .5, label.y = .2) +
  theme_apa()

plt2 = ggplot(L9_L8_ndvi21, aes(x = L9ndvi21, y = L8ndvi21)) +
  geom_point(color = 'green', size=1, alpha = 0.01)+
  xlim(0, 0.8) +   
  ylim(0, 0.8) +
  ggtitle("Year 2021") +
  labs(y = "Landsat 9", x = "Landsat 8") +
  stat_cor(method = "pearson", label.x = .5, label.y = .2) +
  theme_apa()

plt3 = ggplot(S2_L8_ndvi21, aes(x = S2ndvi21, y = L8ndvi21)) +
  geom_point(color = 'green', size=1, alpha = 0.01)+
  xlim(0, 0.8) +   
  ylim(0, 0.8) +
  ggtitle("Year 2021") +
  labs(y = "Sentinel 2", x = "Landsat 8") +
  stat_cor(method = "pearson", label.x = .5, label.y = .2) +
  theme_apa()

plt4 = ggplot(L8_L7_ndvi, aes(x = L8ndvi, y = L7ndvi)) +
  geom_point(color = 'green', size=1, alpha = 0.01)+
  xlim(0, 0.8) +   
  ylim(0, 0.8) +
  ggtitle("Year 2016") +
  labs(y = "Landsat 8", x = "Landsat 7") +
  stat_cor(method = "pearson", label.x = .5, label.y = .2) +
  theme_apa()

plt5 = ggplot(S2_L7_ndvi, aes(x = S2ndvi, y = L7ndvi)) +
  geom_point(color = 'green', size=1, alpha = 0.01)+
  xlim(0, 0.8) +   
  ylim(0, 0.8) +
  ggtitle("Year 2016") +
  labs(y = "Sentinel 2", x = "Landsat 7") +
  stat_cor(method = "pearson" , label.x = .5, label.y = .2)+
  theme_apa()

plt6 = ggplot(S2_L8_ndvi, aes(x = S2ndvi, y = L8ndvi)) +
  geom_point(color = 'green', size=1, alpha = 0.01)+
  xlim(0, 0.8) +   
  ylim(0, 0.8) +
  ggtitle("Year 2016") +
  labs(y = "Sentinel 2", x = "Landsat 8") +
  stat_cor(method = "pearson", , label.x = .5, label.y = .2)+
  theme_apa()


library("gridExtra")
grid.arrange(plt1, plt2, plt3, plt4, plt5, plt6, ncol = 2)
             
