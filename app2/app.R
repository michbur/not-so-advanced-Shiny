library(shiny)
library(shinyjss)

ui <- fluidPage(
  shinyjs::useShinyjs(),
  
  a(id = "toggle", "Show text", href = "#"),
  
  numericInput(inputId = "provided_number", 
               label = "Provide number",
               min = 2,
               max = 20,
               value = 5),
  HTML("<input type='checkbox' id='handy'>"),
  plotOutput("first_plot"),
  div(id = "fav_text",
      textOutput("first_print"),
      textOutput("second_print")
  )
  
)

server <- function(input, output) {
  
  
  shinyjs::onclick("toggle", shinyjs::toggle(id = "fav_text", anim = TRUE))
  
  
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
