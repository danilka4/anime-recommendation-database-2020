library(ggplot2)
library(dplyr)
library(lubridate)
library(stringr)
path <- '../input/anime-recommendation-database-2020/'

list.files(path)

anime <- read.csv(paste(path, 'anime.csv', sep = ''))
anime_with_synopsis <- read.csv(paste(path, 'anime_with_synopsis.csv', sep = ''))
animelist <- read.csv(paste(path, 'animelist.csv', sep = ''))
rating_complete <- read.csv(paste(path, 'rating_complete.csv', sep = ''))
watching_status <- read.csv(paste(path, 'watching_status.csv', sep = ''))

# colnames(anime)
# colnames(anime_with_synopsis)
# colnames(animelist)
# colnames(rating_complete)
# head(watching_status)
# 
# 
# premiered_year <- as.numeric(str_extract(anime$Premiered, "[0-9][0-9][0-9][0-9]"))
# 
# hist(premiered_year)
# 
# plot(premiered_year, anime$Score)
# 
# edited_prem <- anime %>% 
#   mutate(Premiered_year = as.numeric(str_extract(anime$Premiered, "[0-9][0-9][0-9][0-9]")), Score = as.numeric(Score)) %>% 
#   select(Premiered_year, Score)
# 
# ggplot(edited_prem, aes(Premiered_year, Score)) +
#   geom_point() + 
#   geom_smooth()



library(recommenderlab)

ratingmat_init <- as(rating_complete, "realRatingMatrix") %>% normalize()
ratingmat <- ratingmat_init[rowCounts(ratingmat_init) > 300,]









recModel <- Recommender(ratingmat, method = "UBCF", param = list(method = "Cosine", nn = 5))

top5 <- predict(recModel, ratingmat[1], n=10)

top5list <- as(top5, "list")
top5list

top5df <- data.frame(top5list)
top5df

colnames(top5df) <- "MAL_ID"
top5df

top5df$MAL_ID <- as.numeric(top5df$MAL_ID)


library(dplyr)


left_join(top5df, anime_with_synopsis[-c(4,5)], by="MAL_ID")

