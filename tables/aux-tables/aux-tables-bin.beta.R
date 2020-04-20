
# Auxilliary tables: Multinomial -- Dirichlet Model
# These tables are similar to the ones in the poster but the numbers are rounded to 5 decimal places instead of three

rm(list = ls())

library(Hmisc)

source("read-data.r")
source("auxiliary-functions.r")

# a = 1, b = 1 --> Beta(1, 1) priors --> Uniform Prior

results_bi_beta_unif_austria_bl1 <- bi_beta_model(data = Austria, a = rep(1, 9), b = rep(1, 9), bl = 1, probs.round = 5) 
results_bi_beta_unif_belgium_bl1 <- bi_beta_model(data = Belgium, a = rep(1, 9), b = rep(1, 9), bl = 1, probs.round = 5) 
results_bi_beta_unif_ireland_bl1 <- bi_beta_model(data = Ireland, a = rep(1, 9), b = rep(1, 9), bl = 1, probs.round = 5) 
results_bi_beta_unif_Luxembourg_bl1  <- bi_beta_model(data = Luxembourg, a = rep(1, 9), b = rep(1, 9), bl = 1, probs.round = 5) 
results_bi_beta_unif_Portugal_bl1 <- bi_beta_model(data = Portugal, a = rep(1, 9), b = rep(1, 9), bl = 1, probs.round = 5) 

# c = 1
# a = \theta_{0}, b = 1-\theta_{0} --> Beta(\theta_{0}, 1-\theta_{0})

results_bi_beta_dir_c1_austria_bl1 <- bi_beta_model(data = Austria, a = theta_benford(1), b = 1-theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_c1_belgium_bl1 <- bi_beta_model(data = Belgium, a = theta_benford(1), b = 1-theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_c1_ireland_bl1 <- bi_beta_model(data = Ireland, a = theta_benford(1), b = 1-theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_c1_Luxembourg_bl1  <- bi_beta_model(data = Luxembourg, a = theta_benford(1), b = 1-theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_c1_Portugal_bl1 <- bi_beta_model(data = Portugal, a = theta_benford(1), b = 1-theta_benford(1), bl = 1, probs.round = 5) 

# c = 22 for BL1
# a = 22 * \theta_{0}, b = 22-22*\theta_{0} --> Beta(22*\theta_{0}, 22-22*\theta_{0})

results_bi_beta_dir_austria_bl1 <- bi_beta_model(data = Austria, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_belgium_bl1 <- bi_beta_model(data = Belgium, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_ireland_bl1 <- bi_beta_model(data = Ireland, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_Luxembourg_bl1  <- bi_beta_model(data = Luxembourg, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1, probs.round = 5) 
results_bi_beta_dir_Portugal_bl1 <- bi_beta_model(data = Portugal, a = 22*theta_benford(1), b = 22-22*theta_benford(1), bl = 1, probs.round = 5) 

poster.bin.beta.aux <- cbind(
  
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

latex(poster.bin.beta.aux[, c(1:5 ) ], file = "tables/aux-tables/bin-beta-aux-austria.tex", rowlabel = "Digit")
latex(poster.bin.beta.aux[, c(6:10 ) ], file = "tables/aux-tables/bin-beta-aux-belgium.tex", rowlabel = "Digit")
latex(poster.bin.beta.aux[, c(11:15 ) ], file = "tables/aux-tables/bin-beta-aux-ireland.tex", rowlabel = "Digit")
latex(poster.bin.beta.aux[, c(16:20 ) ], file = "tables/aux-tables/bin-beta-aux-luxembourg.tex", rowlabel = "Digit")
latex(poster.bin.beta.aux[, c(21:25 ) ], file = "tables/aux-tables/bin-beta-aux-portugal.tex", rowlabel = "Digit")