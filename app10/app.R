library(shiny)
library(DT)

ui <- fluidPage(
    
    fileInput("input_df", label = "Select .csv file"),
    dataTableOutput("output_df"),
    actionButton("submit", "Submit"),
    tableOutput("filtered_rows")
)

server <- function(input, output) {
    
  df <- reactive({
    validate(need(input[["input_df"]], message = "Provide data file"))
    read.csv(input[["input_df"]][["datapath"]])
  })
  
  medians <- reactive({
    sapply(df()[input[["output_df_rows_all"]], 
                                   sapply(df(), is.numeric)], median)
  })
  
    output[["output_df"]] <- renderDataTable({
      datatable(df(), filter = "top")
    }, server = TRUE)
    
    #https://rstudio.github.io/DT/shiny.html
    
    
    observeEvent(input[["submit"]], {
      output[["filtered_rows"]] <- renderTable({
        data.frame(t(isolate(medians())))
        # if(!is.null(input[["input_df"]])) 
        #   browser()
      })
    })

}

shinyApp(ui = ui, server = server)
