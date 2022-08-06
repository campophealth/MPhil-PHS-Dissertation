# 1) Download all packages required

mypackages <- c("ggplot2", "tidyverse", "pwr", "showtext", "patchwork")
for (p in mypackages){
  if(!require(p, character.only = TRUE)){
    install.packages(p)
    library(p, character.only = TRUE)
  }
}

# 2) Change font to Latin Modern 

font_paths("C:\\Users\\sukan\\AppData\\Local\\Microsoft\\Windows\\Fonts")
c <- font_files() 

font_add(family = "LM Roman 10",
         regular = "lmroman10-regular.otf") 

showtext_auto()

# 3) Set working directory

setwd("setwd")

# 4A) Q-Q plots for all coding variants

# read file of observed p-values
p_obs1 <- read_tsv("all_pval.txt", col_names = FALSE)

# calculate inflation factor
pval <- as.data.frame(p_obs1)
pval$c <- qchisq(1-pval$X1,1)
lambda1 = median(pval$c)/qchisq(0.5,1)

# create expected p-values
df1 <- tibble(p_obs1 = runif(17188)) %>%
  mutate(rank = row_number(p_obs1),
         p_exp = (rank - 0.5)/n())

# create plot 
g1 <- ggplot(df1, aes(x=-log10(p_exp), y=-log10(p_obs1))) +
  geom_point() +
  geom_abline(intercept = 0) +
  theme_classic() +
  theme(axis.title=element_text(size=14, family = "LM Roman 10"),
        axis.text=element_text(size=12, family = "LM Roman 10"),
        legend.title = element_text(size = 10, family = "LM Roman 10"),
        legend.text=element_text(size=10, family = "LM Roman 10")) +
  labs(x = "Expected -log10(p-value)", y = "Observed -log10(p-value)")

# 4B) Q-Q plots for all non synonymous variants

# read file of observed p-values
p_obs2 <- read_tsv("n_pval.txt", col_names = FALSE)

# calculate inflation factor
pval <- as.data.frame(p_obs2)
pval$c <- qchisq(1-pval$X1,1)
lambda2 = median(pval$c)/qchisq(0.5,1)

# create expected p-values
df2 <- tibble(p_obs2 = runif(16450)) %>%
  mutate(rank = row_number(p_obs2),
         p_exp = (rank - 0.5)/n())

# create plot 
g2 <- ggplot(df2, aes(x=-log10(p_exp), y=-log10(p_obs2))) +
  geom_point() +
  geom_abline(intercept = 0) +
  theme_classic() +
  theme(axis.title=element_text(size=14, family = "LM Roman 10"),
        axis.text=element_text(size=12, family = "LM Roman 10"),
        legend.title = element_text(size = 10, family = "LM Roman 10"),
        legend.text=element_text(size=10, family = "LM Roman 10")) +
  labs(x = "Expected -log10(p-value)", y = "Observed -log10(p-value)")

# 4C) Q-Q plots for all missense variants

# read file of observed p-values
p_obs3 <- read_tsv("m_pval.txt", col_names = FALSE)

# calculate inflation factor
pval <- as.data.frame(p_obs3)
pval$c <- qchisq(1-pval$X1,1)
lambda3 = median(pval$c)/qchisq(0.5,1)

# create expected p-values
df3 <- tibble(p_obs3 = runif(16309)) %>%
  mutate(rank = row_number(p_obs3),
         p_exp = (rank - 0.5)/n())

# create plot 
g3 <- ggplot(df3, aes(x=-log10(p_exp), y=-log10(p_obs3))) +
  geom_point() +
  geom_abline(intercept = 0) +
  theme_classic() +
  theme(axis.title=element_text(size=14, family = "LM Roman 10"),
        axis.text=element_text(size=12, family = "LM Roman 10"),
        legend.title = element_text(size = 10, family = "LM Roman 10"),
        legend.text=element_text(size=10, family = "LM Roman 10")) +
  labs(x = "Expected -log10(p-value)", y = "Observed -log10(p-value)")

# 4D) Q-Q plots for frameshift indels and nonsense variants

# read file of observed p-values
p_obs4 <- read_tsv("res_pval.txt", col_names = FALSE)

# calculate inflation factor
pval <- as.data.frame(p_obs4)
pval$c <- qchisq(1-pval$X1,1)
lambda4 = median(pval$c)/qchisq(0.5,1)

# create expected p-values
df4 <- tibble(p_obs4 = runif(4626)) %>%
  mutate(rank = row_number(p_obs4),
         p_exp = (rank - 0.5)/n())

# create plot 
g4 <- ggplot(df4, aes(x=-log10(p_exp), y=-log10(p_obs4))) +
  geom_point() +
  geom_abline(intercept = 0) +
  theme_classic() +
  theme(axis.title=element_text(size=14, family = "LM Roman 10"),
        axis.text=element_text(size=12, family = "LM Roman 10"),
        legend.title = element_text(size = 10, family = "LM Roman 10"),
        legend.text=element_text(size=10, family = "LM Roman 10")) +
  labs(x = "Expected -log10(p-value)", y = "Observed -log10(p-value)")

# 5) Create patchwork of plots

wrap_plots(g1, g2, g3, g4)  + 
  plot_annotation(tag_levels = 'A')
