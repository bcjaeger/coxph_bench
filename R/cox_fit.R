




r_cox_fit <- function(x, y, w, method=0, iter_max=20){

  coxph.fit(x = x,
            y = y ,
            strata = NULL,
            init = rep(0, ncol(x)),
            control = coxph.control(iter.max = iter_max),
            offset = rep(0, nrow(x)),
            weights = w,
            method = if(method == 0) 'breslow' else 'efron',
            rownames = NULL,
            resid = FALSE,
            nocenter = 0)

}

