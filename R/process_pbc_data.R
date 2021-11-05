#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

process_pbc_data <- function() {

  data(pbc, package = 'survival')

  .pbc <- pbc[complete.cases(pbc), ]
  .pbc <- .pbc[order(.pbc$time), ]

  .pbc$status[.pbc$status > 0] <- .pbc$status[.pbc$status > 0] - 1

  x <- as.matrix(.pbc[, -c(1,2,3,6), drop = FALSE])
  y <- Surv(.pbc$time, .pbc$status)
  w <- sample(1:5, size = nrow(x), replace = TRUE)

  list(x=x, y=y, w=w)

}
