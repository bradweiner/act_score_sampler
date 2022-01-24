library(tidyverse)
library(janitor)
library(magrittr)
library(tictoc)
library(skimr)
# library(beepr)

set.seed(1876)

bin1 <- 30:36
bin2 <- 24:29
bin3 <- 18:23
bin4 <- 12:17
bin5 <- 6:11
bin6 <- 1:5

#read in combinations
ac <- read.csv("data/akil_combinations.csv",stringsAsFactors = F)
ac <- filter(ac, total_prob ==1)

#read in test row
temp <- read.csv("data/transformed/first_row_df.csv",stringsAsFactors = F)

#assign s if necessary
s <- ac

#assign i for testing
# i = 1500

#assign constraints
class_size = 1500
class_samp_nbr = 50


tic(msg = "Starting Loop")

for(i in 1:nrow(s)){
    
# s <- ac %>%
#     slice(i) %>%
#     as.data.frame(.)
    

bin1_samp = sample(bin1,size = class_samp_nbr * (class_size * s$var1[i]),replace = T)
bin2_samp = sample(bin2,size = class_samp_nbr * (class_size * s$var2[i]),replace = T)
bin3_samp = sample(bin3,size = class_samp_nbr * (class_size * s$var3[i]),replace = T)
bin4_samp = sample(bin4,size = class_samp_nbr * (class_size * s$var4[i]),replace = T)
bin5_samp = sample(bin5,size = class_samp_nbr * (class_size * s$var5[i]),replace = T)
bin6_samp = sample(bin6,size = class_samp_nbr * (class_size * s$var6[i]),replace = T)

# bin1_samp = sample(bin1,size = class_samp_nbr * (class_size * s$var1),replace = T)
# bin2_samp = sample(bin2,size = class_samp_nbr * (class_size * s$var2),replace = T)
# bin3_samp = sample(bin3,size = class_samp_nbr * (class_size * s$var3),replace = T)
# bin4_samp = sample(bin4,size = class_samp_nbr * (class_size * s$var4),replace = T)
# bin5_samp = sample(bin5,size = class_samp_nbr * (class_size * s$var5),replace = T)
# bin6_samp = sample(bin6,size = class_samp_nbr * (class_size * s$var6),replace = T)

class_vec <- c(bin1_samp,bin2_samp,bin3_samp,bin4_samp,bin5_samp,bin6_samp)

b <- skim(class_vec,)
#method 1
b$id <- s$id[i]

#method 2
# b$id <- s$id

temp <- bind_rows(temp,b)

# Tell about progress
cat('Processing row', i, 'of', nrow(s),'\n')


}

toc()


# #one time only
# 
# write.csv(a,"first_row_df.csv",row.names = F)

#save temp file before it breaks

write.csv(temp, "data/transformed/run_file_pre_join.csv",row.names = F)

# join files together so the ids and props are in there
test <- left_join(temp,s)
head(test)
write.csv(test,"data/transformed/run_file_post_join.csv",row.names = F)

#cleaner file for akil

akil <- test %>%
    select(id,
           act_30_36_prop = var1,
           act_24_29_prop = var2,
           act_18_23_prop = var3,
           act_12_17_prop = var4,
           act_6_11_prop = var5,
           act_1_5_prop = var6,
           total_prob,
           class_mean = numeric.mean,
           class_sd = numeric.sd,
           pct_25 = numeric.p25,
           pct_50 = numeric.p50,
           pct_75 = numeric.p75) %>%
    as.data.frame(.)

head(akil)           

write.csv(akil,"data/final_analytic_files/final_file_for_akil.csv",row.names = F)
