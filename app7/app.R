library(shiny)
library(shinyjs)

ui <- fluidPage(
  
  useShinyjs(),
  
  sidebarLayout(
    #  sidebarPanel = sidebarPanel(
    wellPanel(id = "input_panel",
              fileInput("sequence_file", "Select your file in the fasta format"), 
              textAreaInput(inputId = "sequence_area", label = "Enter your sequence", 
                            placeholder = "Sequence in the fasta format"),
              actionButton(inputId = "submit_sequence_area", 
                           label = "Submit sequences from the field above")
              #    )
    ),
    
    mainPanel = mainPanel(
      shinyjs::hidden(
        wellPanel(id = "main_panel",
                  textOutput("first_print"),
                  tags$p(HTML("<h3><A HREF=\"javascript:history.go(0)\">Start a new query</A></h3>"))
        )
      )
    )
  )
)

server <- function(input, output) {
  
  rv <- reactiveValues(
    sequence = ""
  )
  
  
  observeEvent(input[["submit_sequence_area"]], {
    if(input[["sequence_area"]] != "") {
      rv[["sequence"]] <- input[["sequence_area"]]
      shinyjs::hideElement(id = "input_panel")
      shinyjs::showElement(id = "main_panel")
    }
    
    if(!is.null(input[["sequence_file"]])) {
      rv[["sequence"]] <- readLines(input[["sequence_file"]][["datapath"]])
    }
  })
  
  output[["first_print"]] <- renderText({
    rv[["sequence"]]
  })
  
  
}

shinyApp(ui = ui, server = server)
