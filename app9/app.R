library(shiny)
library(DT)

ui <- fluidPage(
    
    fileInput("input_df", label = "Select .csv file"),
    dataTableOutput("output_df"),
    tableOutput("filtered_rows")
)

server <- function(input, output) {
    
  df <- reactive({
    validate(need(input[["input_df"]], message = "Provide data file"))
    read.csv(input[["input_df"]][["datapath"]])
  })
  
    output[["output_df"]] <- renderDataTable({
      datatable(df(), filter = "top")
    }, server = TRUE)
    
    #https://rstudio.github.io/DT/shiny.html
    output[["filtered_rows"]] <- renderTable({
      df()[input[["output_df_rows_all"]], ]
    })
}

shinyApp(ui = ui, server = server)
