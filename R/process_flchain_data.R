#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

process_flchain_data <- function() {

  data("flchain", package = 'survival')

  df <- flchain

  df$chapter <- NULL

  df$futime[df$futime == 0] <- 0.5

  time <- 'futime'
  status <- 'death'

  df_nomiss <- na.omit(df)

  df_sorted <- df_nomiss[order(df_nomiss[[time]]),]

  df_x <- df_sorted
  df_x[[time]] <- NULL
  df_x[[status]] <- NULL

  x <- model.matrix(~.-1, data = df_x)

  y <- Surv(time = df_sorted[[time]],
            event = df_sorted[[status]])

  w <- sample(1:5, size = nrow(x), replace = TRUE)

  list(x=x, y=y, w=w)

}
