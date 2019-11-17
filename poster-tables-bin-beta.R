
# Binomial -- Beta Model

rm(list = ls())

library(Hmisc)

source("read-data.r")
source("auxiliary-functions.r")

# a = 1, b = 1 --> Beta(1, 1) priors --> Uniform Prior

results_bi_beta_unif_austria_bl1 <- bi_beta_model(data = Austria, a = rep(1, 9), b = rep(1, 9), bl = 1) 
results_bi_beta_unif_belgium_bl1 <- bi_beta_model(data = Belgium, a = rep(1, 9), b = rep(1, 9), bl = 1) 
results_bi_beta_unif_ireland_bl1 <- bi_beta_model(data = Ireland, a = rep(1, 9), b = rep(1, 9), bl = 1) 
results_bi_beta_unif_Luxembourg_bl1  <- bi_beta_model(data = Luxembourg, a = rep(1, 9), b = rep(1, 9), bl = 1) 
results_bi_beta_unif_Portugal_bl1 <- bi_beta_model(data = Portugal, a = rep(1, 9), b = rep(1, 9), bl = 1) 

# c = 1
# a = \theta_{0}, b = 1-\theta_{0} --> Beta(\theta_{0}, 1-\theta_{0})

results_bi_beta_dir_c1_austria_bl1 <- bi_beta_model(data = Austria, a = theta_benford(1), b = 1-theta_benford(1), bl = 1) 
results_bi_beta_dir_c1_belgium_bl1 <- bi_beta_model(data = Belgium, a = theta_benford(1), b = 1-theta_benford(1), bl = 1) 
results_bi_beta_dir_c1_ireland_bl1 <- bi_beta_model(data = Ireland, a = theta_benford(1), b = 1-theta_benford(1), bl = 1) 
results_bi_beta_dir_c1_Luxembourg_bl1  <- bi_beta_model(data = Luxembourg, a = theta_benford(1), b = 1-theta_benford(1), bl = 1) 
results_bi_beta_dir_c1_Portugal_bl1 <- bi_beta_model(data = Portugal, a = theta_benford(1), b = 1-theta_benford(1), bl = 1) 

# c = 22 for BL1
# a = 22 * \theta_{0}, b = 22-22*\theta_{0} --> Beta(22*\theta_{0}, 22-22*\theta_{0})

results_bi_beta_dir_austria_bl1 <- bi_beta_model(data = Austria, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1) 
results_bi_beta_dir_belgium_bl1 <- bi_beta_model(data = Belgium, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1) 
results_bi_beta_dir_ireland_bl1 <- bi_beta_model(data = Ireland, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1) 
results_bi_beta_dir_Luxembourg_bl1  <- bi_beta_model(data = Luxembourg, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1) 
results_bi_beta_dir_Portugal_bl1 <- bi_beta_model(data = Portugal, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1) 


poster.bin.beta <- cbind(
  
  results_bi_beta_unif_austria_bl1[, c("PostProb.H0")],
  results_bi_beta_dir_c1_austria_bl1[, "PostProb.H0"],
  results_bi_beta_dir_austria_bl1[, c("PostProb.H0", "LB.PostProb.H0", "P.value")],
  
  results_bi_beta_unif_belgium_bl1[, "PostProb.H0"],
  results_bi_beta_dir_c1_belgium_bl1[, "PostProb.H0"],
  results_bi_beta_dir_belgium_bl1[, c("PostProb.H0", "LB.PostProb.H0", "P.value")],
  
  results_bi_beta_unif_ireland_bl1[, "PostProb.H0"],
  results_bi_beta_dir_c1_ireland_bl1[, "PostProb.H0"],
  results_bi_beta_dir_ireland_bl1[, c("PostProb.H0", "LB.PostProb.H0", "P.value")],
  
  results_bi_beta_unif_Luxembourg_bl1[, c("PostProb.H0")],
  results_bi_beta_dir_c1_Luxembourg_bl1[, "PostProb.H0"],
  results_bi_beta_dir_Luxembourg_bl1[, c("PostProb.H0", "LB.PostProb.H0", "P.value")],
  
  results_bi_beta_unif_Portugal_bl1[, "PostProb.H0"],
  results_bi_beta_dir_c1_Portugal_bl1[, "PostProb.H0"],
  results_bi_beta_dir_Portugal_bl1[, c("PostProb.H0", "LB.PostProb.H0", "P.value")]
  
  )

colnames(poster.bin.beta) <- c(
  
  "Austria-P(H0|X)1",
  "Austria-P(H0|X)2",
  "Austria-P(H0|X)3",
  "Austria-LB",
  "Austria-pval",
  
  "Belgium-P(H0|X)1",
  "Belgium-P(H0|X)2",
  "Belgium-P(H0|X)3",
  "Belgium-LB",
  "Belgium-pval",
  
  "Ireland-P(H0|X)1",
  "Ireland-P(H0|X)2",
  "Ireland-P(H0|X)3",
  "Ireland-LB",
  "Ireland-pval",
  
  "Luxembourg-P(H0|X)1",
  "Luxembourg-P(H0|X)2",
  "Luxembourg-P(H0|X)3",
  "Luxembourg-LB",
  "Luxembourg-pval",
  
  "Portugal-P(H0|X)1",
  "Portugal-P(H0|X)2",
  "Portugal-P(H0|X)3",
  "Portugal-LB",
  "Portugal-pval"
  )

latex(poster.bin.beta[, c(1:10 ) ], file = "tables/bin-beta-part1.tex", rowlabel = "Digit")
latex(poster.bin.beta[, c(11:20 ) ], file = "tables/bin-beta-part2.tex", rowlabel = "Digit")
latex(poster.bin.beta[, c(21:25 ) ], file = "tables/bin-beta-part3.tex", rowlabel = "Digit")









