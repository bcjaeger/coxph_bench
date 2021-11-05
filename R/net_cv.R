#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

net_cv <- function(x, y, w) {

  cv.glmnet(x = x,
            y = y,
            weights = w,
            family = 'cox')

}
