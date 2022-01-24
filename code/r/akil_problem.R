library(tidyverse)
library(janitor)
library(magrittr)
library(tictoc)


bin1 <- 30:36
bin2 <- 24:29
bin3 <- 18:23
bin4 <- 12:17
bin5 <- 6:11
bin6 <- 1:5


prob_combo <- seq(.7,.99,.01)
prob_combo_2 <- seq(.01,.3,.01)
prob_combo_3 <- seq(.01,.3,.01)
prob_combo_4 <- seq(.01,.3,.01)
prob_combo_5 <- seq(.01,.3,.01)
prob_combo_6 <- seq(.01,.3,.01)

a <- expand.grid(prob_combo,prob_combo_2,prob_combo_3,prob_combo_4,prob_combo_5,prob_combo_6)

b <- as.data.frame(a)
b %<>% clean_names(.)
b %<>% mutate(id = row_number()) %>% as.data.frame(.)
head(b)

##TRYING TO LOOP THROUGH HERE##

#test
blarney <- seq(1,100,1)

blarney <- seq(1,100000000,100000)
blarney <- seq(100000001,200000000,100000)
blarney <- seq(200000001,300000000,100000)
blarney <- seq(300000001,500000000,100000)
blarney <- seq(500000001,729000000,100000)

# i = 1

temp <- b %>% mutate(total_prob = 0) %>% slice(1)

# i = 1

tic("Starting Loop")

for(i in 1:length(blarney)){
    
    c <- b %>%
        # slice(blarney[i]:(blarney[i] + 99999)) %>%
        slice(blarney[i]:(blarney[i] + 1)) %>%
        rowwise() %>%
        mutate(total_prob = sum(var1,var2,var3,var4,var5,var6,na.rm = T)) %>%
        filter(total_prob == 1) %>%
        as.data.frame(.) 
    
    temp <- bind_rows(temp,c)
    
    cat('Processing row', i, 'of', nrow(b),'\n')
    
}

toc(log = TRUE)

keep <- temp
write.csv(temp,"data/transformed/akil_combinations.csv",row.names = F)

###
