library(shiny)
data(mtcars)
diabetesRisk=function(glucose) glucose/200
shinyServer(
  function(input, output)
  {
    output$xValue<-reactive({
      x<-as.numeric(input$mtCar_VAriables1)
      if(x==1)
      {
        "mpg"
      }
      else if(x==2)
      {
        "cyl"
      }
      else if(x==3)
      {
        "disp"
      }
      else if(x==4)
      {
        "hp"
      }
      else if(x==5)
      {
        "dart"
      }
      
      else if(x==6)
      {
        "wt"
      }
      else if(x==7)
      {
        "qsec"
      }
      else if(x==8)
      {
        "vs"
      }
      else if(x==9)
      {
        "am"
      }
      
      else if(x==10)
      {
        "gear"
      }
      else 
      {
        "carb"
      }
    })
    output$yValue<-reactive({
      
      y<-as.numeric(input$mtCar_VAriables2)
      if(y==1)
      {
        "mpg"
      }
      else if(y==2)
      {
        "cyl"
      }
      else if(y==3)
      {
        "disp"
      }
    else if(y==4)
    {
      "hp"
    }
    else if(y==5)
    {
      "dart"
    }
    
    else if(y==6)
    {
      "wt"
    }
    else if(y==7)
    {
      "qsec"
    }
    else if(y==8)
    {
      "vs"
    }
    else if(y==9)
    {
      "am"
    }
    
    else if(x==10)
    {
      "gear"
    }
    else 
    {
      "carb"
    }
  })
    
    output$myPlot<-renderPlot(
      {
        
        x<-as.numeric(input$mtCar_VAriables1)
        y<-as.numeric(input$mtCar_VAriables2)
        plot(mtcars[,x], mtcars[,y], col=c(x, y), xlab = x, ylab = y)
      })
  }
)