#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel(h1("Exponential population growth")),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("population",
                     "Initiall population",
                     min = 1,
                     max = 1000,
                     value = 20),
         sliderInput('r', 
                     'Biothic potential',
                     min = 0.1,
                     max = 1,
                     value = 0.4),
         sliderInput('time', 
                     'Number of generations',
                     min = 1,
                     max = 100,
                     value = 10
                     )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotlyOutput("distPlot")
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   
   output$distPlot <- renderPlotly({
      # generate bins based on input$bins from ui.R
      x <- seq(0, input$time, 1)
      y <- Map(function (xs) (exp(1) ^ (input$r * xs)) * input$population, x)
      
      data <- list(time=x, population=y)
      # draw the histogram with the specified number of bins
      plot_ly(data, x=time, y=population, type='scatter', mode='lines')
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

