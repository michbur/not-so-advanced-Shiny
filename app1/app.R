library(shiny)

ui <- fluidPage(
    
    plotOutput("first_plot")
    
)

server <- function(input, output) {
    
    output[["first_plot"]] <- renderPlot({
        plot(1L:10)
    })
}

shinyApp(ui = ui, server = server)
