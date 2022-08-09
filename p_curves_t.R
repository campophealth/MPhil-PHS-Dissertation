### POWER CURVES FOR THEORETICAL SAMPLE

# 1) Download all packages required

mypackages <- c("ggplot2", "tidyverse", "pwr", "showtext")
for (p in mypackages){
  if(!require(p, character.only = TRUE)){
    install.packages(p)
    library(p, character.only = TRUE)
  }
}

# 2) Change font to Latin Modern 

font_paths("")
c <- font_files() 

font_add(family = "LM Roman 10",
         regular = "lmroman10-regular.otf") 

showtext_auto()

library(pwr)

# 3) Estimate power to detect a single rare variant

alpha <- 0.00001
or <- 2
maf0 <- 0.005
maf1 <- or*maf0/(1 + or*maf0 - maf0)
samples <- 10000
ratio <- 0.5 # Ratio cases to controls

p <- pwr.2p2n.test(h = ES.h(p1 = maf1, p2 = maf0),
                   sig.level = alpha,
                   n1 = round(2*samples*(ratio)),
                   n2 = 2*samples*ratio,
                   alternative = "two.sided")

p

ratio <- 0.50  #Ratio case to controls

# 4) Plot power by effect size to show increase in power with effective MAF

results <- tribble(~samples, ~or, ~maf0, ~maf1, ~power)
i <- 1
for (or in seq(1.01, 3, by = 0.01)) {
  for (maf0 in c(0.001, 0.002, 0.005, 0.01)) {
    for (samples in c(55000)) {
      maf1 <- or*maf0/(1 + or*maf0 - maf0)
      p <- pwr.2p2n.test(h = ES.h(p1 = maf1, p2 = maf0),
                         sig.level = alpha,
                         n1 = round(2*samples*(ratio)),
                         n2 = 2*samples*ratio,
                         alternative = "two.sided")
      power <- p[[5]]
      
      results[i,1] <- samples
      results[i,2] <- or
      results[i,3] <- maf0
      results[i,4] <- maf1
      results[i,5] <- power
      i <- i + 1
    }
  }
}



a <- ggplot(filter(results, samples==55000), aes(x=or, y=100*power, color=as.factor(maf0))) +
  geom_line(size=1.5) +
  theme_bw() +
  theme(axis.title=element_text(size=20, family = "LM Roman 10"),
        axis.text=element_text(size=18, family = "LM Roman 10"),
        legend.title = element_text(size = 16, family = "LM Roman 10"),
        legend.text=element_text(size=16, family = "LM Roman 10")) +
  labs(x = "Odds ratio",
       y = "Power (%)",
       color = "Carrier frequency")
a

