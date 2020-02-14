library(shiny)

ui <- fluidPage(
    
    
    tags$script(src = "change-color.js"),

    numericInput(inputId = "provided_number", 
                 label = "Provide number",
                 min = 2,
                 max = 20,
                 value = 5),
    plotOutput("first_plot"),
    textOutput("first_print"),
    textOutput("second_print")
    
)

server <- function(input, output) {
    
    output[["first_plot"]] <- renderPlot({
        plot(1L:input[["provided_number"]])
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
