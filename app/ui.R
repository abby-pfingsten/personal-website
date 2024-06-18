library(shiny)
library(shinydashboard)
library(shinyjs)
library(plotly)
library(slickR)
library(shinycssloaders)
library(DT)
library(leaflet)


ui <- dashboardPage(
  dashboardHeader(
    title = "Abigale Pfingsten"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      tags$style(HTML("
        .sidebar-menu {
          padding-top: 200px;
        }
      ")),
      menuItem("Work Experience",
        tabName = "work",
        icon = icon("desktop", lib = "font-awesome")
      ),
      menuItem("Education",
        tabName = "education",
        icon = icon("graduation-cap", lib = "font-awesome")
      ),
      menuItem("For Fun!",
        tabName = "fun",
        icon = icon("smile", lib = "font-awesome")
      )
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "purple_theme.css")
    ),
    tags$head(
      tags$link(rel = "icon", type = "image/png", href = "favicon.png")
    ),
    
    # Home ----
    tabItems(
      tabItem(
        tabName = "home",
        fluidPage(
          h2("Abigale Pfingsten",
            style = "text-align: center; font-size: 50px; font-family: Futura Heavy;"
          ),
          h4("R Shiny Developer · Data Analyst · Analytical Consultant",
            style = "text-align: center; font-size: 20px; font-family: Futura Heavy;"
          ),
          fluidRow(
            br(),
            br(),
            br(),
            column(
              width = 6,
              tags$img(src = "utah_hike.jpg", width = "500px")
            ),
            column(
              width = 5,
              br(),
              tags$p("R Shiny developer with experience in designing robust architectures and 
                            crafting efficient server-side and UI/UX components for dynamic applications. I am currently
                            working as Business Analytics Consultant at PNC Bank. Driven by my passion for
                            continuous growth, I have a strong interest to broaden my horizons in 
                            full-stack web development and would like to expand my skillset to include
                            React and/or Angular."),
              tags$hr(style = "border-top: 2px solid #ccc;"),
              tags$p("Outside of work, I enjoy practicing the piano (I've been playing for 17 years),
                                theater, cooking fun dishes, hiking, rock climbing, and traveling the world."),
              tags$hr(style = "border-top: 2px solid #ccc;"),
              tags$a(
                href = "https://www.linkedin.com/in/abigalepfingsten/",
                target = "_blank",
                style = "font-size: 60px; margin-left: 100px",
                icon("linkedin", lib = "font-awesome"),
                tags$a(
                  href = "resume.pdf",
                  target = "_blank",
                  style = "font-size: 50px; margin-left: 150px;",
                  icon("user", lib = "font-awesome")
                )
              )
            )
          )
        )
      ),
      # Work ----
      tabItem(
        tabName = "work",
        fluidPage(
          h1("Work and Research Experience",
            style = "text-align: center;"
          ),
          br(),
          fluidPage(
            ## PNC Full Time ----
            fluidRow(
              column(
                width = 2,
                tags$img(src = "pnc_logo.png", width = "90px")
              ),
              column(
                width = 10,
                h3("PNC Bank | Business Analytics Consultant | 2020 - Present"),
                tags$hr(style = "border-top: 4px solid #ccc;"),
                tags$p("PNC Bank is a financial institution and one of the largest banks in the country, 
                offering a wide range of banking services to individuals, businesses, and organizations."),
                tags$p("In my current position at PNC, I serve as a skilled R Shiny developer, 
                       contributing to the success of various projects. I have taken the lead in developing 
                       five distinct applications, showcasing my ability to drive impactful solutions. 
                       Furthermore, I am responsible for crafting and maintaining dynamic Tabealu dashboards, 
                       performing ad-hoc SQL queries, and conducting comprehensive data analysis. 
                       Excitingly, I am also in the process of joining our API development team, 
                       eager to enhance our utilization of APIs in our applications and provide 
                       debugging support whenever needed."),
                tags$p(
                  "Here are a few projects I worked on while at PNC:"
                ),
                ### RCI ----
                box(
                  h5("R Shiny Application"),
                  h6("Built the architecture, logic flow and sophisticated UI/UX to an application
                     that allows managers to assign advisors to work customers, and track the 
                     relationship. The application also has the ability to allow advisors to add peers and create
                     a 'team' to work the prospect. With distinct functionalities tailored to managers and advisors, 
                     the application seamlessly integrates multiple views, each offering unique features while 
                     maintaining a cohesive user experience. Additionally, a feedback component is strategically 
                     embedded to capture valuable insights from users, further enhancing the customer recommendation model.",
                     style = "color: #8e7cc3"),
                  width = "100%",
                  height = "20%"
                ),
                ### Sherlock ----
                box(
                  h5("R Shiny Application"),
                  h6("Developed an application featuring a Netflix-inspired recommender system, catering to bankers 
                     operating in comparable markets or with similar portfolios. This innovative tool empowers them 
                     with valuable insights, showcasing a curated selection of potential offerings to customers. 
                     The application seamlessly transitioned from a Tableau workbook into a modularized Shiny app, 
                     harnessing the power of plotly and data.table to deliver interactive visualizations and efficient 
                     data processing.", 
                     style = "color: #8e7cc3"),
                  width = "100%",
                ),
                ### DNA Complaint ----
                box(
                  h5("R Shiny Application"),
                  h6("Created a data.table application that allows the user to view potential complaints sent in
                     through our system. A key feature of this request was to embed a button to randomly sample 5% of
                     the population, to mark records to have the user throughouly check. Another request was to have 
                     a button to check across all descriptions of the potential complaints, to see if it contains any of
                     seven trigger words that would indicate dissatisfaction. To enhance communication and streamline the resolution process, 
                     a dedicated email button was implemented, enabling seamless correspondence with the complaint creators for requesting further 
                     information when needed. This application streamlines complaint management, optimizing efficiency and enhancing the 
                     overall user experience.",
                    style = "color: #8e7cc3"),
                  width = "100%",
                ),
                ### BBVA ----
                box(
                  h5("Tableau Dashboard"),
                  h6("During PNC's aquisition of BBVA, I was tasked with a high priority project, to create a dashboard that gave us insight
                     on the transition process of BBVA clients over to PNC. The creation of the query, gathering of data and design/flow of the dashboard all had to happen a very short
                     period of time. This intensive undertaking showcased my ability to thrive under pressure while delivering 
                     exceptional results within a demanding timeframe. By successfully executing this pivotal project, 
                     I contributed to the seamless integration of BBVA clients into the PNC ecosystem, fostering a smooth and
                     positive experience throughout the transition process.",
                     style = "color: #8e7cc3"),
                  width = "100%",
                )
              )
            ),
            ## PNC Intern ----
            fluidRow(
              column(
                width = 2,
                tags$img(src = "pnc_logo.png", width = "90px")
              ),
              column(
                width = 10,
                h3("PNC Bank | Data Analytics Intern | 2019"),
                tags$hr(style = "border-top: 4px solid #ccc;"),
                tags$p("During my time as an intern, I learned how to develop Shiny apps that can 
                     read data from a multitude of big data sources, and write data back to 
                     an external database. I also learned the importance of SQL in how it serves to 
                     capture data from multiple complex sources, to isolate the data to just the information 
                     you need to do analysis on. Additionally, I learned a new skill and was able to develop
                     a handful of Tableau workbooks for a diverse range of business needs."),
                tags$p(
                  "Here are a few projects I worked on during my internship:"
                ),
                box(
                  h5("R Shiny Application"),
                  h6("Built an application that allows the user to view opportunities that they
                     are tied to, and gives them the ability to request certain resources. It was designed
                     to facilitate a smooth transition between the sales organization and the project
                     management team, and to allow for enhanced reporting of the project implementation. 
                     I singlehandedly created this app as an intern, and it is still actively being used 
                     and developed on.",
                     style = "color: #8e7cc3"),
                  width = "100%",
                ),
                box(
                  h5("Capstone Project"),
                  h6("During the last few weeks of our internship, myself and the three other data analyst
                     interns were tasked with making a capstone. We decided to try and find an answer to 
                     as to when a customer might churn, and what preventative measures could be taken in
                     such a case. Some of my responsibilities included gathering the data via SQL, and 
                     creating an app to display the results of our findings. We presented this to a leadership team
                     at the end of the summer.",
                     style = "color: #8e7cc3"),
                  width = "100%",
                )
              )
            ),
            ## Research Assistant CMU ----
            fluidRow(
              column(
                width = 2,
                tags$img(src = "cmu_logo.png", width = "110px")
              ),
              column(
                width = 10,
                h3("Carnegie Mellon University | Research Assistant | 2018 - 2019"),
                tags$hr(style = "border-top: 4px solid #ccc;"),
                tags$p("During my junior and senior year, I participated in research with a professor
                       in the International Relations department. The goal of the research was to try 
                       and understand how 'covert action', and other like terms have been discussed
                       throughout history. I was responsible for taking journals over various years 
                       and converting them from a .pdf to a .txt format via an algorithm I created. Following this,
                       I created a corpus to analyze the texts and was in the procress of developing
                       interactive graphs to visualize how the sentiments of these key words had changed
                       over time."),
                br(),
                br()
              ),
            ),
            ## HHS Intern ----
            fluidRow(
              column(
                width = 2,
                tags$img(src = "hhs_logo.png", width = "110px")
              ),
              column(
                width = 10,
                h3("Department of Health and Human Services | Program Assistant | 2018"),
                tags$hr(style = "border-top: 4px solid #ccc;"),
                tags$p("The Department of Health and Human Services (HHS) 
                       is a U.S. government agency responsible for promoting and 
                       protecting the health and well-being of Americans."),
                tags$p("I gained many valuable skills during my first internship, and was due to my
                       excellent deliverables, was asked to join a group working on a high priority
                       project. At the end of the summer, I was granted a monetary award for my performance
                       and assistance in the aforementioned project."),
                tags$p(
                  "Here is some further details on the projects I worked on during my internship:"
                ),
                box(
                  h5("Geospatial & Data Analytics"),
                  h6("As mentioned, I was part of a team of five working on a high priority project. We had a large
                     influx of data coming in as quickly as by the hour, and we were tasked with efficiently analyzing
                     it and providing the results back to leadership in a timely fashion. I did most of my analysis
                     in R, but also utilized PowerBI for visualizations when presenting my findings to the leadership.",
                     style = "color: #8e7cc3"),
                  width = "100%",
                ),
                box(
                  h5("Data Analytics - R"),
                  h6("I was tasked with analyzing the results of a survey given at an annual meeting 
                     with leadership across the organization. The goal of the analysis was to understand
                     how the leadership was feeling about the policies and procedures that had been implemented 
                     in the past year, as well as existing practices. We also were interested in comparing how the
                     responses differed to the year prior.",
                     style = "color: #8e7cc3"),
                  width = "100%",
                )
              )
            )
          )
        )
      ),
      # Education ----
      tabItem(
        tabName = "education",
        fluidPage(
          h1("Education", style = "text-align: center;"),
          br(),
          fluidRow(
            column(
              2,
              tags$img(src = "open-classrooms.png", width = "150px")
              ),
              column(
                10,
                h3("OpenClassrooms - Web Development Certification | Aug 2023 - June 2024"),
                tags$hr(style = "border-top: 4px solid #ccc;"),
                tags$p("In the fall of 2023, I began a Web Development Certification through OpenClassrooms - it
                       was a project based certification, wherein after each set of courses, you built an application
                       adhering to the requirements or themes of the module. I learned about HTML, CSS/SCSS, 
                       making applications mobile and tablet compatible, SEO practices, Javascript, building 
                       and testing API's, Node.js, and for the final project, built a full-stack React application."),
                tags$p("Please feel free to checkout my GitHub for some of the projects I completed during the course:"),
                div(
                  class = "disclaimers",
                tags$a("Groupomania Full Stack React App", href = "https://github.com/abby-pfingsten/groupomania-react-app"),
                tags$p("A message board app that allows you to create an account, sign in, make a multi-media post (accepts images,
                       audio or video), and view all posts made by other users."),
                tags$p("This app can only be cloned and ran if you have a MySQL server account as it relies on two backend tables 
                       for capturing user information.")
                ),
                div(
                  class = "disclaimers",
                  tags$a("Piquantee App", href = "https://github.com/abby-pfingsten/piiquante-app"),
                  tags$p("An app that allows you to create an account, and add different hot sauces. You can view other users
                         hot sauces, and rate them. You can also delete a hot sauce that you have uploaded. All of these functionalities
                         are accomplished via API's that I built."),
                  tags$p("Only the backend code was written by me (i.e. only files in the backend/ folder).")
                ),
                div(
                  class = "disclaimers",
                  tags$a("E-Commerce App", href = "https://github.com/abby-pfingsten/kanap-ecommerce-app"),
                  tags$p("An  app that queries an API for items, and allows you to have a 'shopping experience' (i.e. you can 
                         add, delete, modify items in your cart and 'checkout')."),
                  tags$p("Only the backend code was written by me (i.e. only files in the backend/ folder).")
                ),
                br(),
                br()
            )
          ),
          fluidRow(
            column(
              2,
              tags$img(src = "cmu_logo.png", width = "150px")
            ),
            column(
              10,
              h3("Carnegie Mellon University | 2016 - 2020"),
              tags$hr(style = "border-top: 4px solid #ccc;"),
              tags$p("I attended Carnegie Mellon University and graduated with a BS in both
                   Statistics and Data Science, and International Relations. I also received
                   a minor Piano Performance. I graduated with University Honors and had a final
                   GPA of 3.66. During my time at CMU, I was involved with Scotch 'n Soda Theater,
                   Tisbert Sketch Comedy, School of Music Chorus, and The Pre-Law Society. During my four
                   years, I worked as a Program Assistant for the Special Music Program, and in my last two
                   years was a TA in the statistics department, and earned a TA award in 2019."),
              br(),
              br()
            )
          ),
          fluidRow(
            column(
              2,
              tags$img(src = "shs_logo.png", width = "150px")
            ),
            column(
              10,
              h3("Steinbrenner High School | 2012 - 2016"),
              tags$hr(style = "border-top: 4px solid #ccc;"),
              tags$p("I attended Steinbrenner High School and graduated in the top 5% of my
                  class at place 28 out of 566 students, with a final unweighted GPA of 3.96/4.00
                   and weighted GPA of 6.85. I was part of the Honors Choir, Women's Choir,
                   National Honors Society and Beta Club."),
              br(),
              br()
            )
          ),
          fluidRow(
            column(
              2,
              tags$img(src = "pc_logo.png", width = "250px")
            ),
            column(
              10,
              h3("Straz Center for the Performing Arts - Patel Conservatory | 2009 - 2016"),
              tags$hr(style = "border-top: 4px solid #ccc;"),
              tags$p("The arts have always held a very important place in my life. I started
                   playing the piano at age seven, but in 2009 we found the instructor that
                   would end up teaching me until graduation at The Straz Center for the Performing
                   Arts. Not only did I continue to improve in piano and go on to compete in state
                   and nationwide competitions, but I also found my love
                   for theater at the Conservatory. By 2016, I had received my Theater Certification from the
                   Conservatory, and I also received my High School Diploma in Social Music from
                   the American College of Musicians.")
            )
          )
        )
      ),
      # Fun ----
      tabItem(
        tabName = "fun",
        fluidPage(
          tags$head(
            tags$script(
              HTML("
        $(document).on('afterChange', '.slick-slider', function(event, slick, currentSlide) {
          Shiny.setInputValue('slideshowIndex', currentSlide);
        });
      ")
            )
          ),
          h2("Just for Fun", style = "text-align:center;"),
          h4("I know it can be hard to get to know a candidate just based off a resume,
           cover letter or even a website. So hopefully this tab allows you to get a
           better idea of who I am!",
            style = "text-align: center; padding-right: 280px; padding-left: 280px"
          ),
          br(),
          ## Travel ----
          fluidRow(
            column(
              12,
              h3("Travel"),
              tags$hr(style = "border-top: 4px solid #ccc;")
            )
          ),
          fluidRow(
            column(
              3,
              init_picker_input("year", "Year"),
              init_picker_input("home", "Home?"),
              init_picker_input("multiple", "Multiple Visits"),
              init_picker_input("future", "Future 2024 Trip"),
              tags$p("Traveling has been embedded in my DNA. My first international flight
          was when I was five, when we flew to Ecuador to live with my mom's family for a year.
          My mom also studied abroad in Israel and France, and when I was growing up,
          we would frequently take cross-country road trips. These are the cities I've
          been able to visit since 2020 (except for places that I consider home), and I hope to continue being able to add to
          this list.", style = "text-align: left;")
            ),
            column(
              9,
              leafletOutput("map", height = "530px") %>%
                withSpinner(color = "#8e7cc3")
            )
          ),
          ## Cooking ----
          fluidRow(
            column(
              12,
              h3("Cooking"),
              tags$hr(style = "border-top: 4px solid #ccc;")
            )
          ),
          fluidRow(
            column(
              3,
              uiOutput("food_comments")
            ),
            column(
              9,
              slickR::slickROutput("slideshow", width = "100%", height = "20%")
            )
          ),
          ## Reads ----
          fluidRow(
            column(
              12,
              h3("Good Reads"),
              tags$hr(style = "border-top: 4px solid #ccc;")
            )
          ),
          fluidRow(
            column(
              2,
              tags$p(
                "Reading was a huge passion of mine growing up,
                     and I'm doing my best to make time for it post-college.
                     I only began tracking my reads since mid-2022,
                     but I'm hoping to continue expanding my collection as
                     the years go by."
              )
            ),
            column(
              10,
              DT::DTOutput("books_read_dt") %>%
                withSpinner(color = "#8e7cc3")
            )
          ),
          ## Piano ----
          fluidRow(
            column(
              12,
              h3("Piano"),
              tags$hr(style = "border-top: 4px solid #ccc;")
            )
          ),
          fluidRow(
            column(
              12,
              tags$p(
                "When applying to college, I wasn't sure what direction to go in, so for
                a large majority of schools, I applied for music. Below are some audition 
                tapes I used, and therefore they are a few years old. Currently, I am working
                on", tags$a(href = "https://www.youtube.com/watch?v=taY5oHleS4I",
                            style = "color:#8e7cc3; font-weight: bold; text-align: center",
                            target = "_blank",
               "Chopin's Ballade No.1 in G minor, Op. 23.",
                style = "text-align: center")
              )
            )
            ),
          fluidPage(
            column(
              6,
              h5(
                "Hungary: Rapsodie Mignonne, Op. 410, Carl Koelling",
                style = "text-align: left; font-weight: bold;"
              )
            ),
            column(
              6,
              h5(
                "Sonata K. 283 Allegro & Andante Movements, W.A. Mozart",
                style = "text-align: left; font-weight: bold;"
              )
            )
          ),
          fluidRow(
            column(
              6,
              uiOutput("piano_vid_1")
            ),
            column(
              6,
              uiOutput("piano_vid_2")
            )
          )
        )
      )
    )
  )
)
