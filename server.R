library(shiny)
library(plotly)
library(ggplot2)

shinyServer(
  function(input, output, session) {

    output$plot1 <- renderPlot({
      
      x <- mtcars[,input$xvar]
      y <- mtcars[,input$yvar]
      
      if (input$gvar != "Default") {
        g <- mtcars[,input$gvar]
        g <- as.factor(g)
      }
      
      if (input$colvar != "Default") {
        c <- mtcars[,input$colvar]
        if (input$colvar == "am") {
          c <- factor(c, levels = c(0,1), labels = c("Automatic", "Manual"))
        } else {
          c <- factor(c, levels = c(0,1), labels = c("V-shaped", "Straight"))
        }
      }
      
      if (input$gvar != "Default" &&  input$colvar != "Default") {
        df <- data.frame(x, y, g, c)
      } else if (input$gvar == "Default" &&  input$colvar != "Default") {
        df <- data.frame(x, y, c)
      } else if (input$gvar != "Default" &&  input$colvar == "Default") {
        df <- data.frame(x, y, g)
      } else {
        df <- data.frame(x, y)
      }
      
      if (input$gvar == "Default" &&  input$colvar == "Default") {
      p <- ggplot(df, aes(x,y)) +
        geom_point(size = 5)
      }
      
      if (input$gvar != "Default" &&  input$colvar == "Default") {
        p <- ggplot(df, aes(x,y)) +
          geom_point(size = 5, aes(col = g)) +
          labs(color = input$gvar)
      }
      
      if (input$gvar == "Default" &&  input$colvar != "Default") {
        p <- ggplot(df, aes(x,y)) +
          geom_point(size = 5) +
          facet_grid(~c)
      }
      
      if (input$gvar != "Default" &&  input$colvar != "Default") {
        p <- ggplot(df, aes(x,y)) +
          geom_point(size = 5, aes(col = g)) +
          facet_grid(~c) +
          labs(color = input$gvar)
      }
      
      p + 
        xlab(input$xvar) + 
        ylab(input$yvar) +
        ggtitle(paste(input$xvar, " vs ", input$yvar)) 

    })
    
  }
)