library(shiny)
library(plotly)
library(ggmap)
library(data.table)
library(dplyr)

cities_visited <- setDT(read.csv("cities_visited.csv"))
books_read <- setDT(read.csv("books_read.csv"))
books_api_endpoint <- "https://openlibrary.org"
google_api_key <- "AIzaSyCUIMpEwalISnYcJPr96SBnntSxh9kXqns"
