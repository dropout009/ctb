library(tidyverse)
library(rstan)
library(shinystan)
options(mc.cores = parallel::detectCores())

df <- read_csv("data/intermediate/df_cleaned.csv")



# HBM NLS by year---------------------------------------------------------------------
st <- stan_model(file = "code/ctb.stan")

data <- list(
  N = nrow(df),
  I = length(unique(df$pid)),
  ID = df$pid,
  X = df$xt/10000,
  K = df$k,
  T0 = df$t0,
  P = df$p
)

init <- list(
  ai = runif(data$I, 0.1, 0.9),
  bi = runif(data$I, 0.1, 0.9),
  di = runif(data$I, 0.1, 0.9),
  s_X = runif(1, 0.1, 1)
)


inits <- list(
    list(
        a = runif(data$I, 0.1, 0.9),
        b = runif(data$I, 0.1, 0.9),
        d = runif(data$I, 0.1, 0.9),
        s_X = runif(1, 0.1, 1)
    ),
    list(
        a = runif(data$I, 0.1, 0.9),
        b = runif(data$I, 0.1, 0.9),
        d = runif(data$I, 0.1, 0.9),
        s_X = runif(1, 0.1, 1)
    ),
    list(
        a = runif(data$I, 0.1, 0.9),
        b = runif(data$I, 0.1, 0.9),
        d = runif(data$I, 0.1, 0.9),
        s_X = runif(1, 0.1, 1)
    ),
    list(
        a = runif(data$I, 0.1, 0.9),
        b = runif(data$I, 0.1, 0.9),
        d = runif(data$I, 0.1, 0.9),
        s_X = runif(1, 0.1, 1)
    )
)

init = list(init)



fit <- sampling(
  st,
  data = data,
  #seed = 1,
  pars = Hmisc::Cs(a, b, d, s_X, lp__),
  #control = list(adapt_delta = 0.95),
  chains = 4,
  init = inits,
  iter = 2000
)

launch_shinystan(fit)







