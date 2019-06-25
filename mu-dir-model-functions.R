
# Functions for the Multinomial-Dirichlet Model -- BL1 or BL2

mu_dir_model <- function(data, alpha, log10 = TRUE, pi_0 = 0.5, bf.round = 2, probs.round = 3){
  
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

