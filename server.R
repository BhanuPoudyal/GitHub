library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  data(mtcars)
  newInput1<-reactive(mtcars[input$mtCar_VAriables1])
  newInput2<-reactvie(mtcars[input$mtCar_VAriables2])
library(ggplot2)
   output$plot <-  qplot(newInput1, newInput2, data = mtcars)
  })


