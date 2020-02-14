library(shiny)

ui <- fluidPage(
    
    tags$head(
        tags$style(HTML("
      .shiny-text-output {
        color: red;
        font-size: 30px;
      }"))
    ),
    
    plotOutput("first_plot"),
    textOutput("first_print"),
    textOutput("second_print")
    
)

server <- function(input, output) {
    
    output[["first_plot"]] <- renderPlot({
        plot(1L:10)
    })
    
    output[["first_print"]] <- renderText({
        x <- "arbuz"
        paste0("Moje ulubione słowo to ", x)
    })
    
    output[["second_print"]] <- renderText({
        x <- "arbuz"
        paste0("Moje ulubione słowo to na pewno ", x)
    })
}

shinyApp(ui = ui, server = server)
