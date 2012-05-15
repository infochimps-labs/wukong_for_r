#!/usr/bin/env r

strip    <- function(string) gsub("(^ +)|( +$)", "", gsub("\n", "", string))
tokenize <- function(string) strsplit(gsub("[^a-zA-Z0-9]+", " ", tolower(strip(string))), " ")

map <- function(input, output) {
  while(length(line <- readLines(input, n=1, warn=FALSE)) > 0) {
    for (token in tokenize(line)) {
      write(paste(token, "1", sep="\t"), output)
    }
  }
}

map(file("stdin", open="r"), stdout())
