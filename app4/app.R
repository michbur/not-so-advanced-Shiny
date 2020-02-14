library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  plotOutput("first_plot", click = "first_plot_click"),
  verbatimTextOutput("first_plot_click_raw")
)

server <- function(input, output) {
  
  rv <- reactiveValues(
    selected_points = c()
  )
  
  observeEvent(input[["first_plot_click"]], {
    rv[["selected_points"]] <-  c(rv[["selected_points"]],
                                  which(nearPoints(iris, coordinfo = input[["first_plot_click"]], maxpoints = 1, allRows = TRUE)[["selected_"]])
    )
  })

  iris_r <- reactive({
    d <- iris
    d[["selected"]] <- FALSE
    if(length(rv[["selected_points"]]) != 0) {
      d[rv[["selected_points"]], "selected"] <- TRUE
    } 
    d
  })
  
  output[["first_plot"]] <- renderPlot({
    ggplot(iris_r(), aes(x = Sepal.Length, y = Petal.Length, color = Species,
                         size = selected)) +
      geom_point()
  })
  
  output[["first_plot_click_raw"]] <- renderPrint({
    nearPoints(iris, coordinfo = input[["first_plot_click"]], maxpoints = 1, allRows = TRUE)
  })
  
}

shinyApp(ui = ui, server = server)
