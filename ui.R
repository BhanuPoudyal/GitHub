library(shiny)
shinyUI(
  pageWithSidebar(
    headerPanel("Relations Between Two Selected Features of a Car"),
    sidebarPanel(
      HTML("<u><b>Please select parameters to plot</b></u>"),
      selectInput("mtCar_VAriables1", label = "First Parameter to Plot:",
                  choices = c( "mpg"=1,  "cyl"=2,   "disp"=3, "hp"=4,   "drat"=5, "wt"=6,   "qsec"=7, "vs"=8,   "am"=9,   "gear"=10, "carb"=11), selected = 3),
      selectInput("mtCar_VAriables2", label = "Second Paraneter to plot",
                  choices = c( "mpg"=1,  "cyl"=2,   "disp"=3, "hp"=4,   "drat"=5, "wt"=6,   "qsec"=7, "vs"=8,   "am"=9,   "gear"=10, "carb"=11), selected = 1),
      submitButton("Submit")
    ),
    mainPanel(
      p("This app uses mtcars data from R packages. User can select two variables from the list at left pannel. After selecting these two variables user must click on submit button to get effects of his/her selection. The boxes below show user what he/she has selected for x-axis and y-axis of his/her plot. After user clicks on submit button the graph displays relations between those two variables."),
      h3("Your selections"),
      h4("You selected at Y-axis"),
      verbatimTextOutput("yValue"),
      h4("You Selected at X-axis"),
      verbatimTextOutput("xValue"),
      plotOutput("myPlot"),
      p("This plot shows you relation between those two variables you have selected."),
      h2("Thank you for using the app!")  
      
    )
  ))