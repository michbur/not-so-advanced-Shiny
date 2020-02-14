library(shiny)
library(shinyjs)

ui <- fluidPage(
  
  actionButton("hide_text", "Click me"),
  numericInput(inputId = "provided_number", 
               label = "Provide number",
               min = 2,
               max = 20,
               value = 5),
  HTML("<input type='checkbox' id='handy'>"),
  plotOutput("first_plot"),
  uiOutput("fav_text")
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
  
  output[["fav_text"]] <- renderUI({
    if(input[["hide_text"]] %% 2 == 0)
      div(textOutput("first_print"),
          textOutput("second_print")
      )
  })
}

shinyApp(ui = ui, server = server)
