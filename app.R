
library(shiny)
library(ggplot2)
library(dplyr)
library(jsonlite)
# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Application title
    titlePanel("Weighted population distribution against the rise of COVID-19 Deaths"),

    sidebarLayout(
        sidebarPanel(
            sliderInput(
              inputId = "Population",
              label = "Filter by max weighted distribution of population: ",
              min = 0,
              max = 100,
              value = 50,
            )
        ),
              
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("scatterPlot")
        )
    )
)

# Define server logic required to draw a scatter plot
server <- function(input, output) {
Covid_Demo<- read.csv("https://raw.githubusercontent.com/narditek/Exploratory-Analysis-Impacts-of-COVID-in-relations-with-Race-and-Deaths/main/Distribution_of_COVID-19_Deaths_and_Populations__by_Jurisdiction__Age__and_Race_and_Hispanic_Origin%20(1).csv")
 output$scatterPlot <- renderPlot({ 
    filter_df<- filter(Covid_Demo,  Weighted.distribution.of.population.... <= input$Population )
    
    # Graphing
       ggplot(data = filter_df, aes( x= Weighted.distribution.of.population...., y= Distribution.of.COVID.19.deaths....)) +
        geom_point()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
