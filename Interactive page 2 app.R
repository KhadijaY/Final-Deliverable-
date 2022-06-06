library(shiny)
library(dplyr)
library(ggplot2)
library(tidyverse)

# Define UI for application that draws a radio button
ui <- fluidPage(
  

    h1("COVID-19 Deaths vs. Race"),
    
    radioButtons(
      inputId  = "Race",
      label = "Choose racial demographic:",
      choices = c("Non-hispanic white", "Non-hispanic black", "Non-hispanic Native or Pacific Islander", "Non-Hispanic Asian", "Hispanic", "Other", "All of the Above"),
      selected = 0
    )
   
)
# Define server logic required to generate bar plot 
server <- function(input, output, session) {
  Covid_Demo<- read.csv("https://raw.githubusercontent.com/narditek/Exploratory-Analysis-Impacts-of-COVID-in-relations-with-Race-and-Deaths/main/Distribution_of_COVID-19_Deaths_and_Populations__by_Jurisdiction__Age__and_Race_and_Hispanic_Origin%20(1).csv", header = TRUE, sep = "," )
data<- reactive({
  req(input$bar)
  covid_df<- Covid_Demo %>% group_by(Count.of.COVID.19.deaths) %>% summarise(Covid_Demo = sum(Race.Hispanic.origin))
  
#Graphing
    output$plot <- renderPlot({
       ggplot(Covid_Demo, aes(y=Race.Hispanic.origin, x= Count.of.COVID.19.deaths, fill = Race.Hispanic.origin)) +
       geom_bar(stat = "sum")+ 
      scale_fill_manual(values = c("Non-Hispanic White" ="red","Non-Hispanic Black" ="blue","Non-Hispanic Asian" ="green","Non-Hispanic American Indian or Alaska Native" = "yellow", "Hispanic" = "black","Other" ="grey"))
      
})
    })    
}
# Run the application 
shinyApp(ui = ui, server = server)
 
