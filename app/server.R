# Libraries ----
library(shiny)
library(plotly)
library(slickR)
library(httr)
library(jsonlite)
library(tidygeocoder)
library(leaflet)
library(readxl)

# api key <- AIzaSyCUIMpEwalISnYcJPr96SBnntSxh9kXqns
# Define server logic
server <- function(session, input, output) {


  # Map Setup ----

  # grab the geocoded cities from `tidygeocoder` so 
  # as to prevent lag
  geocoded_cities <- read_excel("geocoded_cities.xlsx")
  
  # use the code below if new cities are added
  # geocoded_cities <- cities_visited %>%
  #   geocode(city, method = "osm", full_results = TRUE)
  
 
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
