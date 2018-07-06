
#' Make a variable persistent
#' @description
#' Make a variable persistent and remove it from interactive scope.
#' The persistent variables will not be cleaned by the \code{rm(list = ls())}.
#'
#' @param a_var The variable to make persisence
#'
#' @details
#' The persisted variables are session-specific. They will be gone after you restart R
#'
#' Note that if you define a new variable with the same name as the persisted variable,
#' the new variable will mask the persisted one until it is removed.
#' @export
#'
#' @examples
#' x <- "hello"
#' persist(x)
#' # x is now not in the .GlobalEnv but still accessible
persist <- function(a_var) {
  make_persist_env()
  assign(deparse(substitute(a_var)), a_var, envir = as.environment("__persist"))
  rm(list = deparse(substitute(a_var)), pos = ".GlobalEnv")
  invisible(NULL)
}

#' Get or create the persistent environment to store the persisted variable
#' @export
#' @return the environment used by the package
make_persist_env <- function(env_name = "__persist") {
  if (!(env_name %in% search())) {
    g <- new.env()
    attach(g, name = env_name)
  }
  invisible(as.environment(env_name))
}


#' Clear all variables in the interactive environment
#' @export
rm_all <- function() {
  rm(list = ls(pos = ".GlobalEnv"), pos = ".GlobalEnv")
  invisible(NULL)
}