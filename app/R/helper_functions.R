#' Init Picker Input
#' @param ui_id the UI ID of the filter
#' @param label label name
#'
init_picker_input <- function(ui_id,
                              label) {
  input <- shinyWidgets::pickerInput(
    ui_id,
    label = label,
    choices = NULL,
    multiple = TRUE,
    options = list(
      `live=search` = TRUE,
      `actions-box` = TRUE,
      `select-all-text` = "All",
      `size` = 12,
      `selected-text-format` = "count > 1",
      `count-selected-text` = "Multiple Selected"
    )
  )
  return(input)
}

#' Populate picker input
#' @param session standard session object from Shiny
#' @param ui_id the UI id to tie it to the init_picker
#' @param data the DT with information to populate the filters
#'
populate_picker_input <- function(session,
                                  ui_id,
                                  data) {
  if (ui_id %in% "year") {
    years <- sort(ifelse(is.na(data[, year]), "NA", data[,year]))
    choices <- unique(years)
    selected <- choices
  } else if (ui_id %in% "home") {
    choices <- c("TRUE", "FALSE")
    selected <- "FALSE"
  } else if (ui_id %in% "multiple") {
    choices <- c("TRUE", "FALSE")
    selected <- choices
  } else if (ui_id %in% "future") {
    choices <- c("TRUE", "FALSE")
    selected <- choices
  }

  shinyWidgets::updatePickerInput(
    session,
    ui_id,
    choices = choices,
    selected = selected
  )
}

#' Get the GeoCode of a city from google maps API
#' @param city_name name of the city
#' @param api_key api key
#'
geocode_city <- function(city_name, api_key) {
  city_coord_dt <- geocode(city_name, key = api_key) %>%
    setDT()

  lat <- city_coord_dt$lon
  lon <- city_coord_dt$lat

  return(list(lon, lat))
}

#' Get Book Information from API
#' @param book_dt data.table containing book information
#' @param endpoint API endpoint
#'
get_book_information <- function(book_dt,
                                 endpoint) {
  # title <- book_dt$name
  # author <- book_dt$author
  #
  # request_url <- paste0(endpoint, "/search.json", "?title=",
  #                       URLencode(title)
  # )
  #
  #
  # timeout_seconds <- 20
  #
  # # Create a configuration object with the timeout option
  # response <- GET(request_url)
  # browser()
  #
  # if (status_code(response) == 200) {
  #   json_data <- content(response, as = "text", encoding = "UTF-8")
  #   parsed_data <- fromJSON(json_data, flatten = TRUE)
  #   first_book <- parsed_data$docs
  #   first_book <- first_book[1, "subject"]
  #   genre <- first_book$subject
  # } else {
  # }
  #
  text <- character()

  for (i in 1:nrow(book_dt)) {
    title <- book_dt[i, name]

    request_url <- paste0(
      endpoint, "/search.json", "?title=",
      URLencode(title)
    )

    response <- GET(request_url)

    json_data <- content(response, as = "text", encoding = "UTF-8")
    parsed_data <- fromJSON(json_data, flatten = TRUE)
    parsed_data <- parsed_data$docs
    book_subject <- parsed_data[1, "subject_key"][[1]]

    book_sub_collapse <- paste(book_subject, collapse = " ")

    # book_sub_gsub <- gsub("[[:punct:]]", "", book_sub_collapse)

    # book_sub_gsub <- gsub("\\b(?:a|an|the|or|so|it|in|and)\\b", "", book_sub_gsub, ignore.case = TRUE)

    unique_book_subject <- unique(strsplit(book_sub_collapse, " ")[[1]])

    text <- append(text, unique_book_subject)
  }

  text <- tolower(unique(toupper(text)))

  return(text)
}
