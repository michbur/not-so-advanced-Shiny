library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  plotOutput("first_plot", click = "first_plot_click"),
  verbatimTextOutput("first_plot_click_raw")
)

server <- function(input, output) {
  
  rv <- reactiveValues(
    selected_points = c(),
    last_point = c()
  )
  
  observeEvent(input[["first_plot_click"]], {
    
    last_point <- rownames(nearPoints(iris, coordinfo = input[["first_plot_click"]], 
                                      maxpoints = 1, allRows = FALSE))
    
    if(length(last_point) > 0)
      if(last_point %in% rv[["selected_points"]]) {
        rv[["selected_points"]] <- setdiff(rv[["selected_points"]], last_point)
      } else {
        rv[["selected_points"]] <- c(rv[["selected_points"]], last_point)
      }
    
    rv[["last_point"]] <- nearPoints(iris, coordinfo = input[["first_plot_click"]], 
                                     maxpoints = 1, allRows = FALSE)
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
    rv[["selected_points"]]
  })
  
}

shinyApp(ui = ui, server = server)
