library(shiny)
library(DT)

ui <- fluidPage(
  
  fileInput("input_df", label = "Select .csv file"),
  dataTableOutput("output_df"),
  tableOutput("filtered_rows")
)

server <- function(input, output) {
  
  proxy = dataTableProxy("output_df")
  
  rv <- reactiveValues(
    df = NULL
  )
  
  observeEvent(input[["input_df"]], {
    rv[["df"]] <- read.csv(input[["input_df"]][["datapath"]], stringsAsFactors = FALSE)
  })
  
  observeEvent(input[["output_df_cell_edit"]], {
    info <- input[["output_df_cell_edit"]]
    i <- info[["row"]]
    j <- info[["col"]]
    v <- info[["value"]]
    rv[["df"]][i, j] <- DT::coerceValue(v, rv[["df"]][i, j])
    replaceData(proxy, rv[["df"]], resetPaging = FALSE)  
  })
  
  
  
  output[["output_df"]] <- renderDataTable({
    validate(need(input[["input_df"]], message = "Provide data file"))
    datatable(rv[["df"]], filter = "top", editable = TRUE)
  }, server = TRUE)
  
  #https://rstudio.github.io/DT/shiny.html
  output[["filtered_rows"]] <- renderTable({
    # if(!is.null(input[["input_df"]])) 
    #   browser()
    validate(need(input[["input_df"]], message = "Provide data file"))
    
    table(rv[["df"]][[which(sapply(rv[["df"]], is.character))]])
  })
}

shinyApp(ui = ui, server = server)
