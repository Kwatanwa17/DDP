library(shiny)
library(plotly)
library(ggplot2)


shinyUI(pageWithSidebar(
  headerPanel("Make your plot"),
  
  sidebarPanel(
    h4("Select x and y varables of the mtcars data set"),
    h4("Also you can customize the plot using colored variable and grouped variable !"),
    selectInput(inputId = "xvar", label = strong("X (predictor)"),
                choices = c("mpg", "disp", "hp", "drat", "wt", "qsec"), selected = "wt"),
    selectInput(inputId = "yvar", label = strong("Y (outcome)"),
                choices = c("mpg", "disp", "hp", "drat", "wt", "qsec"), selected = "mpg"),
    selectInput(inputId = "gvar", label = strong("Colored by"),
                choices = c("cyl", "gear", "carb", "Default"), selected = "Default"),
    selectInput(inputId = "colvar", label = strong("Separated by"),
                choices = c("am", "vs", "Default"), selected = "Default")
  ),
  
  mainPanel(
    h3("Your plot"),
    plotOutput("plot1")
  )
))
