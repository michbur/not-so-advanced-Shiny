library(shiny)

ui <- fluidPage(
    
    plotOutput("first_plot"),
    textOutput("first_print")
    
)

server <- function(input, output) {
    
    output[["first_plot"]] <- renderPlot({
        plot(1L:10)
    })
    
    output[["first_print"]] <- renderText({
        x <- "arbuz"
        paste0("Moje ulubione słowo to ", x)
    })
}

shinyApp(ui = ui, server = server)
