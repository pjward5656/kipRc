#' Quick rates and confidence intervals
#'
#' This function creates rates and 1-alpha confidence intervals using the Rothman/Greenland method.
#' @param numerator The numerator of the rate.
#' @param denominator The denominator of the rate.
#' @param alpha The significance level for the confidence interval
#' @param multplier The multiplier for the rate. Defaults to 100,000.
#' @keywords Rates
#' @export
#' @examples
#' rate_ci()

rate_ci<-function(numerator, denominator, alpha, multplier=100000){
  list(
    (numerator/denominator)*multplier,
    exp(log((numerator/denominator)*multplier)-(qnorm(alpha/2, lower.tail=FALSE)*(1/sqrt(numerator)))),
    exp(log((numerator/denominator)*multplier)+(qnorm(alpha/2, lower.tail=FALSE)*(1/sqrt(numerator))))
  )
}

