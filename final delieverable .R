#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(hrbrthemes)

#upload the datset
Covid_Dem<- read.csv("https://raw.githubusercontent.com/narditek/Exploratory-Analysis-Impacts-of-COVID-in-relations-with-Race-and-Deaths/main/Distribution_of_COVID-19_Deaths_and_Populations__by_Jurisdiction__Age__and_Race_and_Hispanic_Origin%20(1).csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Distribution of Covid Death"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                "range",
                "Number of Covid-19 deaths:",
                min = 0,
                max = 300,
                value = 300
            )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("histPlot")
        )
    )
)


hrbrthemes::import_roboto_condensed()
       
        Covid_Dem %>%
            filter( Distribution.of.COVID.19.deaths....<300 ) %>%
            ggplot( aes(x=Distribution.of.COVID.19.deaths....)) +
            geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8) +
            ggtitle("Distribution of Covid-19 deaths") + theme_ipsum()


# Run the application 
        shinyApp(ui, server)
