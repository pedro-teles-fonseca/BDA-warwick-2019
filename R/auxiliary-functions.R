
## Auxiliary functions

mantissa <- function(x){ # returns the mantissae of the input numbers
  
  x <- abs(x)
  e <- ifelse(x == 0, 0, floor(log10(x)))
  m <- x / 10^e
  round(m, 10)
}

msdigit <- function(x){ # returns the most significant digit for each element in the input vector
  
  x <- x[x != 0]
  x <- floor(mantissa(x))
  return(x)
}

smsdigit <- function(x){ # returns the second most significant digit for each element in the input vector
  
  x <- x[x != 0 & (x %% 10 == 0 | mantissa(x) != floor(mantissa(x)))]
  x <- floor((mantissa(x)*10)) %% 10
  return(x)
}

bl_length_without_NAs <- function(v){ # returns vector lenght excluding missing values
  
  return(
    c(
      length(!is.na(msdigit(v))),
      length(!is.na(smsdigit(v)))
    )
  )
}

theta_benford <- function(d){
  
  if (d == 1){
    theta_benford <- sapply(1:9, function(x){log10(1+1/(x))})
  } else if (d == 2){
    theta_benford <- sapply(0:9, function(x){sum(log10(1+1/(10*(1:9)+x)))})
  }
  return(theta_benford)
}

bcal <- function(p, l = NULL) { # P-Value Calibration from Selke, Bayarri & Berger (2001) 
# Calibrates p-values into lower bounds for Bayes Factors in favour of the null
  
  if (missing(l)){  
    
    ifelse(p>1, stop("p>1", call. = FALSE),
           ifelse(p<0, stop("p<0", call. = FALSE),
                  ifelse(p==0, 0, 
                         ifelse(p < (1 / exp(1)), -1*exp(1)*p*log(p), 1)
                  )
           )
    )
    
  } else  {
    
    ifelse(p>1, stop("p>1", call. = FALSE),
           ifelse(p<0, stop("p<0", call. = FALSE),
                  ifelse(p==0, log(0, base=l), 
                         ifelse(p < (1 / exp(1)), log(-1*exp(1)*p*log(p),base = l), log(1, base=l))
                  )
           )    
    )
    
  }
}

pcal <- function(p, prob = 0.5){ # P-Value Calibrations from Selke, Bayarri & Berger (2001) 
# Calibrates p-values into lower bounds for posterior probability of the null. 
  
  ifelse(p > 1 , stop("p>1 -- Invalid p-value.", call. = FALSE),
         ifelse(p < 0, stop("p<0 -- invalid p-value.", call. = FALSE),
                ifelse(p == 0, 0, 
                       ifelse(p<(1/exp(1)), return((1+((1-prob)/prob)*(1/bcal(p)))^(-1)), 
                              return((1+((1-prob)/prob)*(1/bcal(p)))^(-1)))
                )
         )	
  )
}

bl1_analysis <- function(x){ # Benford's law for first digit analysis
  # Returns sample size, observed and expected counts and proportions, chi-squared test, and z-test
  
  n <- length(msdigit(x))
  dims = c(0.1, 0.05, 0.01, 0.005, 0.001)
  
  out <-  data.frame(
    digit = 1:9,
    x_observed = as.vector(table(msdigit(x))),
    x_expected = n*theta_benford(1),
    theta_observed = as.vector(table(msdigit(x))/n),
    theta_expected = theta_benford(1)
  )
  
  test <- chisq.test(out$x_observed, p = theta_benford(1))
  
  z_stats <- vector(length = 9)
  p_ztest <- vector(length = 9)
  
  for(i in 1:9){
    z_stats[i] <- (abs(out$theta_observed[i]-theta_benford(1)[i])-(1/(2*n)))/sqrt((theta_benford(1)[i]*(1-theta_benford(1)[i]))/n)
    p_ztest[i] <- 2* (1-pnorm(abs(z_stats[i]), 0, 1))
  } 
  
  list(
    n = n,
    table = out, 
    chi_test = list(
      H0 = "Conformance to Benford's law",
      method = test$method,
      statistic = test$statistic,
      p_value = test$p.value,
      results = data.frame(
        dimension = dims,
        decision = sapply(dims, 
                           function(d, pv){if(pv<d){"Reject H0"} else {"Don't reject H0"}},
                           pv = test$p.value
        )
      )
    ),
    z_test = list(
      H0 = "Conformance to Benford's law",
      results = data.frame(
        digit = 1:9,
        z_stat = z_stats,
        p_value = p_ztest
      )
    )
  )
} 

bl2_analysis <- function(x){ # Benford's law for second digit analysis
  # Returns sample size, observed and expected counts and proportions, chi-squared test, and z-test
  
  n <- length(smsdigit(x))
  dims = c(0.1, 0.05, 0.01, 0.005, 0.001)
  
  out <-  data.frame(
    digit = 0:9,
    x_observed = as.vector(table(smsdigit(x))),
    x_expected = n*theta_benford(2),
    theta_observed = as.vector(table(smsdigit(x))/n),
    theta_expected = theta_benford(2)
  )
  
  test <- chisq.test(out$x_observed, p = theta_benford(2))
  
  z_stats <- vector(length = 10)
  p_ztest <- vector(length = 10)
  
  for(i in 0:9){
    z_stats[i] <- (abs(out$theta_observed[i]-theta_benford(2)[i])-(1/(2*n)))/sqrt((theta_benford(2)[i]*(1-theta_benford(2)[i]))/n)
    p_ztest[i] <- 2* (1-pnorm(abs(z_stats[i]), 0, 1))
  } 
  
  list(
    n = n,
    table = out, 
    chi_test = list(
      H0 = "Conformance to Benford's law",
      method = test$method,
      statistic = test$statistic,
      p_value = test$p.value,
      results = data.frame(
        dimension = dims,
        decision = sapply(dims, 
                           function(d, pv){if(pv<d){"Reject H0"} else {"Don't reject H0"}},
                           pv = test$p.value
        )
      )
    ),
    z_test = list(
      H0 = "Conformance to Benford's law",
      results = data.frame(
        digit = 0:9,
        z_stat = z_stats,
        p_value = p_ztest
      )
    )
  )
} 

mu_dir_model <- function(data, alpha, log10 = TRUE, pi_0 = 0.5, bf.round = 2, probs.round = 3){ # Function to compute the Multinomial-Dirichlet Model results (BL1 or BL2)
  
  sample_name <- deparse(substitute(data))
  theta_null_bl1 <- theta_benford(1)
  theta_null_bl2 <- theta_benford(2)
  
  x_bl1 <- as.numeric(table(msdigit(data)))
  p_value_bl1 <-  bl1_analysis(data)$chi_test$p_value
  alpha_bl1 <- alpha[[1]]
  
  x_bl2 <- as.numeric(table(smsdigit(data)))
  p_value_bl2 <-  bl2_analysis(data)$chi_test$p_value
  alpha_bl2 <- alpha[[2]]
  
  bf_fun <- function(theta_null, x, alpha){
    exp(
      sum(x * log(theta_null)) + sum(lgamma(alpha)) + lgamma(sum(alpha + x)) - lgamma(sum(alpha)) - sum(lgamma(alpha + x))
    )
  }
  
  bf_bl1 <- bf_fun(theta_null_bl1, x_bl1, alpha_bl1)
  bf_bl2 <- bf_fun(theta_null_bl2, x_bl2, alpha_bl2)
  
  result <- function(bf, p_value){
    r <- data.frame(
      "BayesFactor" = round(ifelse(log10 == FALSE, bf, log10(bf)), bf.round),
      "Evidence" = ifelse(bf < 1, "Negative", 
                          ifelse(bf < 3.2, "Weak", 
                                 ifelse(bf < 10, "Substantial", 
                                        ifelse(bf < 100, "Strong",
                                               "Decisive")))
      ),
      "PostProb.H0" = round(((1 + ((1 - pi_0) / pi_0) * (1 / bf)))^(-1), probs.round),
      "LB.PostProb.H0" = round(pcal(p_value), probs.round), 
      "P.value" = round(p_value, probs.round)
    )
    
    rownames(r) <- if(bf == bf_bl1){
      paste0(sample_name, "-BL1")
    } else {
      paste0(sample_name, "-BL2")
    }
    
    if(log10 == TRUE){names(r) <- gsub("BayesFactor", "log10(BayesFactor)", names(r))}
    
    return(r)
  }
  
  return(rbind(
    result(bf_bl1, p_value_bl1), 
    result(bf_bl2, p_value_bl2))
  )
} 

bi_beta_model <- function( # Function to compute Binomial-Beta model results (BL1 or BL2)
  data, a = rep(1, 9),
  b = rep(1, 9),
  log10 = TRUE, 
  pi_0 = 0.5, bl = 1, 
  bf.round = 2, 
  probs.round = 3){ 
  
  if(bl == 1){
    theta_null <- theta_benford(1)
    x <- as.numeric(table(msdigit(data)))
    n <- length(msdigit(data))
    digits <- 1:9
    p_values <- round(bl1_analysis(data)$z_test$results$p_value, probs.round)
  } else {
    theta_null <- theta_benford(2)
    x <- as.numeric(table(smsdigit(data)))
    n <- length(smsdigit(data))
    digits <- 0:9
    p_values <- round(bl2_analysis(data)$z_test$results$p_value, probs.round)
  }
  
  bf <- function(x, theta_null, a, b){
    exp(
      x * log(theta_null) + (n - x) * log(1 - theta_null) + lgamma(a) + lgamma(b) + lgamma(a + b + n) -
        (lgamma(a + b) + lgamma(b + n - x) + lgamma(a + x))
    )
  }
  
  bfs <- mapply(bf, x, theta_null, a, b)
  
  result <- data.frame(
    "Digit" = digits,
    "BayesFactors" = round(if(log10 == FALSE){bfs} else{log10(bfs)}, bf.round),
    "Evidence" = ifelse(bfs < 1, "Negative",
                        ifelse(bfs < 3.2, "Weak",
                               ifelse(bfs < 10, "Substantial",
                                      ifelse(bfs < 100, "Strong",
                                             "Decisive")))
    ),
    "PostProb.H0" = round(((1 + ((1 - pi_0) / pi_0) * (1 / bfs)))^(-1), probs.round),
    "LB.PostProb.H0" = round(pcal(p_values), probs.round),
    "P.value" = p_values
  )
  
  if(log10 == TRUE){names(result) <- gsub("BayesFactors", "log10(BayesFactors)", names(result))}
  return(result)

  }
