
# Poster tables: Multinomial -- Dirichlet Model

rm(list = ls())

library(Hmisc)

source("R/read-data.r")
source("R/auxiliary-functions.r")

results_uniform_prior <- rbind(
  
  mu_dir_model(data = Austria, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Belgium, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Finland, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = France, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Germany, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Greece, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Ireland, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Italy, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Luxembourg, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Netherlands, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Portugal, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Spain, alpha = list(rep(1, times = 9), rep(1, times = 10))),
  mu_dir_model(data = Pooled.sample, alpha = list(rep(1, times = 9), rep(1, times = 10)))
  
)

results_centered_dir <- rbind(
  
  mu_dir_model(data = Austria, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Belgium, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Finland, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = France, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Germany, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Greece, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Ireland, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Italy, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Luxembourg, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Netherlands, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Portugal, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Spain, alpha = list(theta_benford(1), theta_benford(2))),
  mu_dir_model(data = Pooled.sample, alpha = list(theta_benford(1), theta_benford(2)))
  
)

results_centered_unimodal_dir <- rbind(
  
  mu_dir_model(data = Austria, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Belgium, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Finland, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = France, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Germany, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Greece, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Ireland, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Italy, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Luxembourg, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Netherlands, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Portugal, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Spain, alpha = list(22*theta_benford(1), 12*theta_benford(2))),
  mu_dir_model(data = Pooled.sample, alpha = list(22*theta_benford(1), 12*theta_benford(2)))
  
)

poster.results <- data.frame(
  c(
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Austria"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Belgium"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Finland"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "France"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Germany"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Greece"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Ireland"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Italy"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Luxembourg"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Netherlands"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Portugal"],
    as.data.frame(apply(data, 2, bl_length_without_NAs))[, "Spain"],
    bl_length_without_NAs(Pooled.sample)
  ),
  results_uniform_prior[, "PostProb.H0" ],
  results_centered_dir[, "PostProb.H0"],
  results_centered_unimodal_dir[, c("PostProb.H0", "LB.PostProb.H0", "P.value")]
)

colnames(poster.results) <- c(
  "N",
  "PostProb.H0.unif.prior",

  "PostProb.H0.dir.prior", 

  "PostProb.H0.dir.prior2",
  
  "LB.PostProb.H0.dir.prior2", 
  "P.value"
)

bl1.results <- poster.results[
  c("Austria-BL1",
    "Belgium-BL1",
    "Finland-BL1",
    "France-BL1",
    "Germany-BL1",
    "Greece-BL1",
    "Ireland-BL1",
    "Italy-BL1",
    "Luxembourg-BL1",
    "Netherlands-BL1",
    "Portugal-BL1",
    "Spain-BL1",
    "Pooled.sample-BL1"
    ),
  ]

bl2.results <- poster.results[
  c("Austria-BL2",
    "Belgium-BL2",
    "Finland-BL2",
    "France-BL2",
    "Germany-BL2",
    "Greece-BL2",
    "Ireland-BL2",
    "Italy-BL2",
    "Luxembourg-BL2",
    "Netherlands-BL2",
    "Portugal-BL2",
    "Spain-BL2",
    "Pooled.sample-BL2"
  ),
  ]

poster.results.final <- cbind(
  bl1.results,
  bl2.results
)
rownames(poster.results.final) <- c("Austria",
  "Belgium",
  "Finland",
  "France",
  "Germany",
  "Greece",
  "Ireland",
  "Italy",
  "Luxembourg",
  "Netherlands",
  "Portugal",
  "Spain",
  "Pooled.sample"
)

latex(unname(poster.results.final), file = "tables/mu-dir.tex", rowlabel = "Country")


