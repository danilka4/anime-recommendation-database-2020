path <- '../input/anime-recommendation-database-2020/ml-latest-small/'

movies <- read.csv(paste(path, 'movies.csv', sep = ''))
links <- read.csv(paste(path, 'links.csv', sep = ''))
ratings <- read.csv(paste(path, 'ratings.csv', sep = ''))
tags <- read.csv(paste(path, 'tags.csv', sep = ''))


head(movies)
head(links)
head(ratings)
head(tags)



summary(movies)
summary(links)
summary(ratings)
summary(tags)


library(stringr)
library(tidyr)
library(recommenderlab)



head(ratings)

new_ratings <- ratings[-4]

ratingmat <- as(new_ratings, "realRatingMatrix") %>% normalize()

recModel <- Recommender(ratingmat, method = "UBCF", param = list(method = "Cosine", nn = 10))

top5 <- predict(recModel, ratingmat[1], n=5)

top5list <- as(top5, "list")
top5list

top5df <- data.frame(top5list)
top5df

colnames(top5df) <- "movieId"
top5df

top5df$movieId <- as.numeric(top5df$movieId)


library(dplyr)


left_join(top5df, movies, by="movieId")
