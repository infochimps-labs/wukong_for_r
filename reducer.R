#!/usr/bin/env r

parse <- function(line) {
  val <- unlist(strsplit(line, "\t"))
  list(token=val[1], count=as.integer(val[2]))
}

process <- function(current, new, output) {
  if (new$token == current$token) {
    current$count <- current$count + new$count
    current
  } else {
    write(paste(current$token, current$count, sep="\t"), output)
    new
  }
}

reduce <- function(input, output) {
  current <- list(token="__first_token__", count=0)
  while(length(line <- readLines(input, n=1, warn=FALSE)) > 0) {
    current <- process(current, parse(line), output)
  }
}

reduce(file("stdin",open="r"), stdout())
