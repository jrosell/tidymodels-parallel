# R CMD BATCH tidymodels-gbm.R

# Preparations =========
cat(paste0("loading ",Sys.time(),"\n"))
suppressPackageStartupMessages({
    # suppressMessages, suppressWarnings...
    # {r warning = FALSE, message=FALSE}
    # knitr::opts_chunk$set( message = FALSE, warning = FALSE ) 
    library(tidyverse)
    library(tidymodels)
    library(bonsai)
    library(future)
    library(lightgbm)
    library(xgboost)
})

cat(paste0("settings ",Sys.time(),"\n"))
args=(commandArgs(TRUE))
if(length(args)==0){
    print("No arguments supplied. Defining default settings")
    n_rsamples <- 3
    n_observations <- 1e4
    n_grid <- 2
} else {
    for(i in 1:length(args)){
        eval(parse(text=args[[i]]))
    }
}

cat(paste0("data ",Sys.time(),"\n"))
form <- class ~ .
set.seed(1)

dat <- sim_classification(n_observations)
glimpse(dat)

cat(paste0("split ",Sys.time(),"\n"))
set.seed(1)
dat_split <- initial_split(dat)
dat_train <- training(dat_split)
dat_test <- testing(dat_split)
dat_folds <- vfold_cv(dat_train, v = n_rsamples)

cat(paste0("grid ",Sys.time(),"\n"))
spec_bt <-
    boost_tree(learn_rate = tune(), trees = tune()) %>%
    set_mode("classification")
set.seed(1)
grid_bt <-
    spec_bt %>%
    extract_parameter_set_dials() %>%
    grid_latin_hypercube(size = n_grid)
glimpse(grid_bt)


# XGBoost =========

cat(paste0("xgboost sequential ",Sys.time(),"\n"))
plan(sequential)
timing_xgb_1 <- system.time({
    res <-
        tune_grid(
            spec_bt %>% set_engine("xgboost", nthread = 5),
            form,
            dat_folds,
            grid = grid_bt
        )
})

cat(paste0("xgboost tidymodels ",Sys.time(),"\n"))
plan(multisession, workers = 5)
timing_xgb_2 <- system.time({
    res <-
        tune_grid(
            spec_bt %>% set_engine("xgboost", nthread = 1),
            form,
            dat_folds,
            grid = grid_bt
        )
})

cat(paste0("xgboost both ",Sys.time(),"\n"))
plan(multisession, workers = 5)
timing_xgb_3 <- system.time({
    res <-
        tune_grid(
            spec_bt %>% set_engine("xgboost", nthread = 5),
            form,
            dat_folds,
            grid = grid_bt
        )
})


# LightGBM =========

cat(paste0("lightgbm sequential ",Sys.time(),"\n"))
plan(sequential)
timing_lgb_1 <- system.time({
    res <-
        tune_grid(
            spec_bt %>% set_engine("lightgbm", num_threads = 5),
            form,
            dat_folds,
            grid = grid_bt
        )
})

cat(paste0("lightgbm tidymodels ",Sys.time(),"\n"))
 plan(multisession, workers = 5)
timing_lgb_2 <- system.time({
    res <-
        tune_grid(
            spec_bt %>% set_engine("lightgbm", num_threads = 1),
            form,
            dat_folds,
            grid = grid_bt
        )
})

cat(paste0("lightgbm both ",Sys.time(),"\n"))
plan(multisession, workers = 5)
timing_lgb_3 <- system.time({
    res <-
        tune_grid(
            spec_bt %>% set_engine("lightgbm", num_threads = 5),
            form,
            dat_folds,
            grid = grid_bt
        )
})


# Results =========

cat(paste0("Results ",Sys.time(),"\n"))

results <- tibble(
    n_rsamples = n_rsamples,
    n_observations = n_observations,
    n_grid = n_grid,
    approach = c("user_engine_only", "user_tidymodels_only", "user_both", "elapsed_engine_only", "elapsed_tidymodels_only", "elapsed_both"),
    xgboost = c(timing_xgb_1[['user.self']], timing_xgb_2[['user.self']], timing_xgb_3[['user.self']], timing_xgb_1[['elapsed']], timing_xgb_2[['elapsed']], timing_xgb_3[['elapsed']]),
    lightgbm = c(timing_lgb_1[['user.self']], timing_lgb_2[['user.self']], timing_lgb_3[['user.self']], timing_lgb_1[['elapsed']], timing_lgb_2[['elapsed']], timing_lgb_3[['elapsed']])
)

library(tidymodels)

print(results)
write_rds(
    results,
    paste0("results_", gsub(" ", "-", Sys.time()), ".rds")
)