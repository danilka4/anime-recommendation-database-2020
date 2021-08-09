library(ggplot2)
library(dplyr)
library(lubridate)
library(stringr)
path <- '../input/anime-recommendation-database-2020/'

list.files(path)

# anime_with_synopsis <- read.csv(paste(path, 'anime_with_synopsis.csv', sep = ''))
# animelist <- read.csv(paste(path, 'animelist.csv', sep = ''))
anime <- read.csv(paste(path, 'anime.csv', sep = ''))
rating_complete <- read.csv(paste(path, 'rating_complete.csv', sep = ''))
# watching_status <- read.csv(paste(path, 'watching_status.csv', sep = ''))

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

ratingmat_init <- as(rating_complete, "realRatingMatrix") 
ratingmat <- ratingmat_init[rowCounts(ratingmat_init) > 200,] %>% normalize()









recModel <- Recommender(ratingmat, method = "UBCF", param = list(method = "Cosine", nn = 10))

top5 <- predict(recModel, ratingmat[1], n=10)

top5list <- as(top5, "list")

top5df <- data.frame(top5list)

colnames(top5df) <- "MAL_ID"

top5df$MAL_ID <- as.numeric(top5df$MAL_ID)


left_join(top5df, anime[1:4], by="MAL_ID")

tim_list_title <- c("Akame ga Kill!", "Another", "Ansatsu Kyoushitsu", "Ansatsu Kyoushitsu 2nd Season", "Bakemonogatari",
                    "Boku dake ga Inai Machi", "Boku no Hero Academia", "Boku no Hero Academia 2nd Season", "Boku no Hero Academia 3rd Season", "Bungou Stray Dogs",
                    "Bungou Stray Dogs 2nd Season", "Bungou Stray Dogs 3rd Season", "Charlotte", "Chuunibyou demo Koi ga Shitai!", "Danganronpa 3: The End of Kibougamine Gakuen - Kibou-hen",
                    "Danganronpa 3: The End of Kibougamine Gakuen - Mirai-hen", "Danganronpa 3: The End of Kibougamine Gakuen - Zetsubou-hen", "Darling in the FranXX", "Death Parade", "Dr. Stone",
                    "Eromanga-sensei", "Fate/Zero", "Fullmetal Alchemist: Brotherhood", "Goblin Slayer", "Gokushufudou",
                    "Great Teacher Onizuka", "Hanamonogatari", "Hotaru no Haka", "JoJo no Kimyou na Bouken (TV)", "JoJo no Kimyou na Bouken Part 3: Stardust Crusaders",
                    "JoJo no Kimyou na Bouken Part 3: Stardust Crusaders 2nd Season", "JoJo no Kimyou na Bouken Part 4: Diamond wa Kudakenai", "JoJo no Kimyou na Bouken Part 5: Ougon no Kaze", "Jujutsu Kaisen (TV)", "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
                    "Kaguya-sama wa Kokurasetai?: Tensai-tachi no Renai Zunousen", "Kakegurui", "KakeguruiÃ—Ã—", "Kaze no Tani no NausicaÃ¤", "Kimetsu no Yaiba",
                    "Kimi no Na wa.", "Kiseijuu: Sei no Kakuritsu", "Kiznaiver", "Kizumonogatari I: Tekketsu-hen", "Kizumonogatari II: Nekketsu-hen",
                    "Kizumonogatari III: Reiketsu-hen", "Kobayashi-san Chi no Maid Dragon", "Koe no Katachi", "Kono Subarashii Sekai ni Shukufuku wo!", "Kono Subarashii Sekai ni Shukufuku wo! 2",
                    "Kono Subarashii Sekai ni Shukufuku wo!: Kurenai Densetsu", "Koyomimonogatari", "Made in Abyss", "Mahou Shoujo Madokaâ˜…Magica", "Mob Psycho 100",
                    "Mob Psycho 100 II", "Monogatari Series: Second Season", "Naruto", "Naruto: Shippuuden", "Nekomonogatari: Kuro",
                    "Neon Genesis Evangelion", "Neon Genesis Evangelion: The End of Evangelion", "Nisemonogatari", "No Game No Life", "One Punch Man",
                    "Ookami Kodomo no Ame to Yuki", "Owarimonogatari", "Owarimonogatari 2nd Season", "Prison School", "Re:Zero kara Hajimeru Isekai Seikatsu",
                    "Saiki Kusuo no Î¨-nan", "Seishun Buta Yarou wa Bunny Girl Senpai no Yume wo Minai", "Sen to Chihiro no Kamikakushi", "Shigatsu wa Kimi no Uso", "Shingeki no Kyojin",
                    "Shingeki no Kyojin Season 2", "Shingeki no Kyojin Season 3", "Shingeki no Kyojin Season 3 Part 2", "Shingeki no Kyojin: The Final Season", "Shokugeki no Souma",
                    "Shokugeki no Souma: Ni no Sara", "Shokugeki no Souma: San no Sara", "Shokugeki no Souma: San no Sara - Tootsuki Ressha-hen", "Steins;Gate 0", "Summer Wars",
                    "Sword Art Online", "Sword Art Online Alternative: Gun Gale Online", "Sword Art Online II", "Toki wo Kakeru Shoujo", "Tokyo Ghoul", 
                    "Tsukimonogatari", "Yakusoku no Neverland", "Yakusoku no Neverland 2nd Season", "Yojouhan Shinwa Taikei", "Youjo Senki",
                    "Youkoso Jitsuryoku Shijou Shugi no Kyoushitsu e (TV)", "Zoku Owarimonogatari")

tim_list_score <- c(2,6,8,10,9,
                    8,7,7,7,8,
                    9,7,6,2,9,
                    7,8,5,6,8,
                    3,7,10,6,3,
                    9,7,10,9,9,
                    8,8,10,9,7,
                    7,8,7,7,9,
                    9,8,6,10,10,
                    10,9,10,8,8,
                    7,6,8,7,8,
                    10,10,8,10,7,
                    10,10,9,6,6,
                    10,9,10,10,6,
                    8,7,9,5,8,
                    7,7,10,8,8,
                    8,7,7,8,4,
                    4,5,3,5,9,
                    7,9,2,8,7,
                    7, 9)

timdf <- data.frame(Name = tim_list_title, Score = tim_list_score)

tim_final <- left_join(timdf, anime[1:2], by="Name") %>% select(MAL_ID, Score) %>% mutate(user_id = 123456789, rating = Score, anime_id = MAL_ID) %>% select(user_id, anime_id, rating)

rating_complete_tim <- rbind(rating_complete, tim_final)

ratingmat_tim <- as(rating_complete_tim, "realRatingMatrix")

ratingmat_tim <- ratingmat_tim[c(rowCounts(ratingmat_tim) >= 200, dim(ratingmat_tim)[1]),] %>% normalize()



recModel_tim <- Recommender(ratingmat_tim, method = "UBCF", param = list(method = "Cosine", nn = 20))


tim_list <- as(predict(recModel_tim, tail(ratingmat_tim, n=1), n = 200), "list")

tim_df <- data.frame(tim_list)

colnames(tim_df) <- "MAL_ID"

tim_df$MAL_ID <- as.numeric(tim_df$MAL_ID)


library(dplyr)


left_join(tim_df, anime[1:4], by="MAL_ID")[,2:4]



gema_list_title <- c("Death Note", "Kimetsu no Yaiba", "Kimetsu no Yaiba Movie: Mugen Ressha-hen", "Kiseijuu: Sei no Kakuritsu", "Koe no Katachi",
                     "Ouran Koukou Host Club", "Vampire Knight", "Yakusoku no Neverland")
gema_list_score <- c(10, 8, 9, 5, 8,
                     8, 5, 7)


gemadf <- data.frame(Name = gema_list_title, Score = gema_list_score)

gema_final <- left_join(gemadf, anime[1:2], by="Name") %>% select(MAL_ID, Score) %>% mutate(user_id = 987654321, rating = Score, anime_id = MAL_ID) %>% select(user_id, anime_id, rating)

rating_complete_gema <- rbind(rating_complete, gema_final)

ratingmat_gema <- as(rating_complete_gema, "realRatingMatrix")

ratingmat_gema <- ratingmat_gema[c(rowCounts(ratingmat_gema) >= 200, dim(ratingmat_gema)[1]),] %>% normalize()



recModel_gema <- Recommender(ratingmat_gema, method = "UBCF", param = list(method = "Cosine", nn = 20))


gema_list <- as(predict(recModel_gema, tail(ratingmat_gema, n=1), n=200), "list")

gema_df <- data.frame(gema_list)

colnames(gema_df) <- "MAL_ID"

gema_df$MAL_ID <- as.numeric(gema_df$MAL_ID)


left_join(gema_df, anime[1:4], by="MAL_ID")

pre_rate_complete_new <-rbind(rating_complete, tim_final, gema_final) 

rating_complete_new <- as(pre_rate_complete_new, "realRatingMatrix")

ratingmat_final <- rating_complete_new[c(rowCounts(rating_complete_new) >= 200, dim(rating_complete_new)[1] - 1, dim(rating_complete_new)[1]),] %>% normalize()



recModel_final <- Recommender(ratingmat_final, method = "UBCF", param = list(method = "Cosine", nn = 10))


final_list <- as(predict(recModel_final, tail(ratingmat_final, n=1), n = 200), "list")





final_df <- data.frame(final_list)

colnames(final_df) <- "MAL_ID"

final_df$MAL_ID <- as.numeric(final_df$MAL_ID)


library(dplyr)


left_join(final_df, anime[1:4], by="MAL_ID") %>% select(Name, Score, Genres)
