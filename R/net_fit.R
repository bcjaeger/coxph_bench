#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param x
#' @param y
#' @param w
#'
net_fit <- function(x, y, w) {

  glmnet(x = x,
         y = y,
         weights = w,
         family = 'cox')

}
