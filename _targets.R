## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

# you need to run tar_make(callr_function = NULL)
# to make this work.
sourceCpp('src/cox_fit.cpp')

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

  data_pbc = process_pbc_data(),
  data_flchain = process_flchain_data(),

  test_pbc = cox_test(data_pbc),
  test_flchain = cox_test(data_flchain),

  bench_pbc = microbenchmark(
    glmnet_cv = net_cv(x, y, w),
    glmnet = net_fit(x, y, w),
    surv = r_cox_fit(x, y, w),
    orsf = c_cox_fit(x, y, w),
    setup = {
      x <- data_pbc$x
      y <- data_pbc$y
      w <- data_pbc$w
    },
    control = list(order = 'inorder'),
    times = 500
  ),

  bench_flchain = microbenchmark(
    glmnet_cv = net_cv(x, y, w),
    glmnet = net_fit(x, y, w),
    surv = r_cox_fit(x, y, w),
    orsf = c_cox_fit(x, y, w),
    setup = {
      x <- data_flchain$x
      y <- data_flchain$y
      w <- data_flchain$w
    },
    control = list(order = 'inorder'),
    times = 500
  ),

  bench_combined = bind_rows(
    pbc = process_bench_data(bench_pbc),
    flchain = process_bench_data(bench_flchain),
    .id = 'data'
  ),

  tar_render(report, "index.Rmd")


)
