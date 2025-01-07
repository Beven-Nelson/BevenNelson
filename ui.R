library(shiny)
library(tidyverse)

categorical_variable <- c("am", "gear", "carb", "vs", "cyl")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(title = div(
    img(src ="shiny.png",height = 50, width = 100),
    "Exploration using Shiny"
  )),
  
  # Sidebar with inputs
  sidebarLayout(
    sidebarPanel(
      h3("Explore mtcars"),
      varSelectInput(
        inputId = "continuous_variable",
        label = "Select the continuous variable",
        data = select(mtcars, -all_of(categorical_variable)),
        selected = "mpg"
      ),
      varSelectInput(
        inputId = "categorical_variable",
        label = "Select the categorical variable",
        data = mtcars[categorical_variable],
        selected = "cyl"
      ),
      varSelectInput(
        inputId = "other_continuous_variable",
        label = "Select another continuous variable for correlation",
        data = select(mtcars, -all_of(categorical_variable)),
        selected = "disp"
      ),
      sliderInput(
        inputId = "bins",
        label = "Number of bins:",
        min = 2,
        max = 20,
        value = 10
      ),
      h4("Plot Variable Map Guide"),
      p(
        "mpg: Miles/(US) gallon", br(),
        "cyl: Number of cylinders", br(),
        "disp: Displacement (cu.in.)", br(),
        "hp: Gross horsepower", br(),
        "drat: Rear axle ratio", br(),
        "wt: Weight (1000 lbs)", br(),
        "qsec: 1/4 mile time", br(),
        "vs: Engine (0 = V-shaped, 1 = straight)", br(),
        "am: Transmission (0 = automatic, 1 = manual)", br(),
        "gear: Number of forward gears", br(),
        "carb: Number of carburetors"
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          title = "Plot for Observing Trends",
          plotOutput("p1"),
          plotOutput("p2")
        ),
        tabPanel(
          title = "Plot for Observing Correlation",
          plotOutput("p3")
        ),
        tabPanel(
          title = "Plot for Observing Inner Subdivision Value",
          plotOutput("p4")
        )
      )
    )
  )
))
