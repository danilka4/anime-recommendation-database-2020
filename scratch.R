path <- '../input/anime-recommendation-database-2020/'

list.files(path)

anime <- read.csv(paste(path, 'anime.csv', sep = ''))
anime_with_synopsis <- read.csv(paste(path, 'anime_with_synopsis.csv', sep = ''))
animelist <- read.csv(paste(path, 'animelist.csv', sep = ''))
rating_complete <- read.csv(paste(path, 'rating_complete.csv', sep = ''))
watching_status <- read.csv(paste(path, 'watching_status.csv', sep = ''))

head(anime, 1)
head(anime_with_synopsis)
head(animelist)
head(rating_complete)
head(watching_status)
