
# Functions for the Binomial-Beta Model -- BL1 or BL2


bf_bi_beta <- function(data, a = rep(1, 9), b = rep(1, 9), log10 = TRUE, pi_0 = 0.5, bl = 1, bf.round = 2, probs.round = 3){
  
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
      x * log(theta_null) + (n - x) * log(1-theta_null) + lgamma(a) + lgamma(b) + lgamma(n + a + b) -
      (lgamma(a + b) + lgamma(n + a - x) + lgamma(x + a))
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
