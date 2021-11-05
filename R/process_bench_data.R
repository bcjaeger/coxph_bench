#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

process_bench_data <- function(bench, divby = 10e6) {

  as_tibble(bench) |>
    mutate(expr = recode(expr, 'glmnet_cv' = 'glmnet.cv')) |>
    group_by(expr) |>
    mutate(id = seq(n())) |>
    pivot_wider(names_from = expr,
                values_from = time) |>
    select(-id) |>
    mutate(across(.cols = everything(),
                  .fns = ~.x / orsf,
                  .names = "{.col}_rel")) |>
    pivot_longer(cols = everything(),
                 values_to = 'time',
                 names_to = 'expr') |>
    group_by(expr) |>
    summarize(mean = mean(time),
              median = median(time)) |>
    separate(expr, into = c('expr', 'type'), sep = '_', fill = 'right') |>
    mutate(type = replace(type, is.na(type), 'abs')) |>
    pivot_wider(names_from = type, values_from = c(mean, median)) |>
    arrange(desc(mean_abs)) |>
    mutate(across(ends_with('abs'), ~ .x / divby))

}
