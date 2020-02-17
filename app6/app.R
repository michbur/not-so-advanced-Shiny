library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      fileInput("sequence_file", "Select your file in the fasta format"), 
      textAreaInput(inputId = "sequence_area", label = "Enter your sequence", 
                    placeholder = "Sequence in the fasta format"),
      actionButton(inputId = "submit_sequence_area", 
                   label = "Submit sequences from the field above")
    ),
    mainPanel = mainPanel(
      textOutput("first_print")
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
