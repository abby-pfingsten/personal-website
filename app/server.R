# Libraries ----
library(shiny)
library(plotly)
library(ggmap)
library(slickR)
library(httr)
library(jsonlite)
library(tidygeocoder)
library(leaflet)
library(readxl)

# api key <- AIzaSyCUIMpEwalISnYcJPr96SBnntSxh9kXqns
# Define server logic
server <- function(session, input, output) {
  # register_google(google_api_key)


  # Map Setup ----

  # use google API to get the coordinates of the cities
  # cities_visited_coord <- data.frame(lat = numeric(), lon = numeric())
  # cities <- cities_visited$city
  
  # grab the geocoded cities from `tidygeocoder` so 
  # as to prevent lag
  geocoded_cities <- read_excel("geocoded_cities.xlsx")
  
  # use the code below if new cities are added
  # geocoded_cities <- cities_visited %>%
  #   geocode(city, method = "osm", full_results = TRUE)
  
  # for (i in 1:length(cities)) {
  #   cities_visited_coord[i, ] <- geocode_city(cities[i], google_api_key)
  # }
  # 
  # # add them to my dataset
  # cities_visited[, `lat` := cities_visited_coord$lat]
  # cities_visited[, `lon` := cities_visited_coord$lon]
  # 
  # # get the center of the lats/lons
  # lat_range <- range(cities_visited_coord$lat)
  # lon_range <- range(cities_visited_coord$lon)
  # 
  # center_lat <- (lat_range[1] + lat_range[2]) / 2
  # center_lon <- (lon_range[1] + lon_range[2]) / 2
  # 
  # cities_visited[, `year` := ifelse(is.na(year), "NA", year)]


  ## Filters ----
  populate_picker_input(session, "year", cities_visited)
  populate_picker_input(session, "home", cities_visited)
  populate_picker_input(session, "multiple", cities_visited)
  populate_picker_input(session, "future", cities_visited)



  observeEvent(
    list(
      input$year,
      input$home,
      input$multiple,
      input$future
    ),
    {
      cities_visited <- cities_visited %>%
        filter(
          year %in% input$year,
          home %in% input$home,
          multiple %in% input$multiple,
          city_for_this_year %in% input$future
        )

      ## Map Output ----
      
      output$map <- renderLeaflet({
        leaflet(geocoded_cities) %>%
          addTiles() %>% # Use OpenStreetMap tiles
          addMarkers(~long, ~lat, popup = ~city)
      })
      # output$map <- renderPlotly({
      #   map <- plot_ly(
      #     cities_visited,
      #     type = "scattermapbox",
      #     mode = "markers",
      #     lat = ~lat,
      #     lon = ~lon,
      #     text = ~city,
      #     color = ~ factor(year),
      #     hovertemplate = paste0(
      #       "City:\t<b>",
      #       cities_visited$city,
      #       "</b><br>",
      #       "Home:\t<b>",
      #       ifelse(cities_visited$home %in% "TRUE", "Yes", "No"),
      #       "</b><br>",
      #       "Year First Visited:\t<b>",
      #       cities_visited$year,
      #       "</b><br>",
      #       "Times Visited (Since 2020):\t<b>",
      #       ifelse(is.na(cities_visited$times & cities_visited$home == TRUE), "NA", 
      #              ifelse(is.na(cities_visited$times & cities_visited$home == FALSE), 1, 
      #                     cities_visited$times)
      #              ),
      #       "</b><br>"
      #     ),
      #     
      #     marker = list(
      #       size = 15
      #     )
      #   ) %>%
      #     layout(
      #       mapbox = list(
      #         style = "carto-positron",
      #         zoom = 1,
      #         center = list(
      #           lat = center_lat,
      #           lon = center_lon
      #         )
      #       )
      #     )
      # 
      #   map
      # })
    }
  )

  # Cooking Slideshow ----

  output$slideshow <- renderSlickR({
    imgs <- list.files("www/foodie", pattern = ".jpg", full.names = TRUE)
    slickR(imgs)
  })

  index_r <- shiny::reactiveVal(0)
  observeEvent(input$slideshowIndex, {
    index <- input$slideshowIndex

    index_r(index)
  })

  ## Text on Food ----
  observeEvent(index_r(), {
    if (index_r() == 0) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Chicken Ceaser Salad:",
            "<li> homemade croutons </li>",
            "<li> homemade ceaser dressing </li>
        "
          )
        )
      )
    } else if (index_r() == 1) {
      output$food_comments <- renderUI(
        HTML(paste0(
          "Caramel Flan:",
          "<li> homemade condensed milk </li>"
        ))
      )
    } else if (index_r() == 2) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Key Lime Pie:",
            "<li> homemade graham crust </li>",
            "<li> key lime juice curd </li>"
          )
        )
      )
    } else if (index_r() == 3) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Mozarella, Prosciutto, and Spinach Pan Pizza:",
            "<li> homemade san marzano red sauce </li>",
            "<li> homemade double 0 flour pizza dough </li>"
          )
        )
      )
    } else if (index_r() == 4) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Goat Cheese, Spinach and Mushroom Quiche:",
            "<li> homemade pie crust </li>"
          )
        )
      )
    } else if (index_r() == 5) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Chocolate Cake:",
            "<li> homemade chocolate butter cream </li>",
            "<li> fresh candied strawberries </li>"
          )
        )
      )
    } else if (index_r() == 6) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Empanadas: ",
            "<li> homemade fried empanada dough...grandma's secret recipe </li>",
            "<li> stuffed with ground beef, oaxaca cheese and black beans </li"
          )
        )
      )
    } else if (index_r() == 7) {
      output$food_comments <- renderUI(
        HTML(
          paste0(
            "Espresso Martini: ",
            " <li> shot of homemade espresso </li>",
            "<li> shot of vodka </li>",
            "<li> shot of homemade simple syrup </li>",
            "<li> cinammon garnish </li>"
          )
        )
      )
    }
  })

  # Books ----

  ## API ----

  # for (i in 1:nrow(books_read)) {
  # text <- get_book_information(books_read, books_api_endpoint)
  # browser()
  # }

  ## DT Setup ----
  book_dt_colnames <- c(
    "Book Title",
    "Author",
    "Type",
    "Finished Reading"
  )

  book_dt_col_index <- c(
    "name",
    "author",
    "type",
    "year"
  )

  books_read <- books_read[
    order(books_read$year)
  ]

  ## Render DT ----
  output$books_read_dt <- DT::renderDT({
    DT::datatable(
      books_read[, ..book_dt_col_index],
      rownames = FALSE,
      colnames = book_dt_colnames,
      options = list(
        dom = "ftp"
      )
    )
  })
  
  
  # Piano ----
  output$piano_vid_1 <- renderUI({
    url <- parse_url("https://www.youtube.com/watch?v=hS9OaIT6HMY")
    video_id <- url$query$v
    
    tags$iframe(
      src = paste0("https://www.youtube.com/embed/", video_id),
      width = "500",
      height = "300",
      frameborder = "0",
      allowfullscreen = "allowfullscreen"
    )
  })
  
  output$piano_vid_2 <- renderUI({
    url <- parse_url("https://www.youtube.com/watch?v=yTzgC6WTVIE&t=20s")
    video_id <- url$query$v
    
    tags$iframe(
      src = paste0("https://www.youtube.com/embed/", video_id),
      width = "500",
      height = "300",
      frameborder = "0",
      allowfullscreen = "allowfullscreen"
    )
  })
}
