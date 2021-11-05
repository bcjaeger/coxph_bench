


cox_test <- function(data, method=0, iter_max=20){

  x <- data$x
  y <- data$y
  w <- data$w

  tt = r_cox_fit(x, y, w, method, iter_max)

  tt_inf <-
    coxph(y~x,
          weights = w,
          ties = if(method == 0) 'breslow' else 'efron') |>
    summary() |>
    getElement("coefficients")

  tt_inf <- tt_inf[,'Pr(>|z|)']

  # prevent x from being modified in place
  xx <- x[, , drop = FALSE]

  orsf = c_cox_fit(xx,
                   y,
                   w,
                   method = method,
                   eps = 1e-9,
                   iter_max = iter_max)

  tibble(
    variable = colnames(x),
    orsf_beta = orsf[, 1],
    surv_beta = tt$coefficients,
    orsf_stderr = orsf[, 2],
    surv_stderr = sqrt(diag(tt$var)),
    orsf_pvalue = orsf[, 3],
    surv_pvalue = tt_inf
  )

}
