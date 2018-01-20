data {
  int N;
  int I;
  int ID[N];
  vector[N] X;
  real K[N];
  real T0[N];
  real P[N];
}

parameters {
  real <lower = 0, upper = 1> a[I];
  real <lower = 0, upper = 1> b[I];
  real <lower = 0, upper = 1> d[I];
  real<lower = 0> s_X;
}

transformed parameters {
  vector[N] mu;

  for (n in 1:N) {
    mu[n] =  1 / ((P[n] * b[ID[n]]^T0[n] * d[ID[n]]^K[n])^(1/(1-a[ID[n]])) + P[n]);
  }
}


model {
    
    for (i in 1:I) {
       a[i] ~ beta(1, 1);
       b[i] ~ beta(1, 1);
       d[i] ~ beta(1, 1);
    }
  
  X ~ normal(mu, s_X);
}
