# Attach Packages
library(shiny)
library(tidyverse)
library(palmerpenguins)


# Create User interface
ui <- fluidPage(
    titlePanel(" I am adding a TITLE!"),
    sidebarLayout(
        sidebarPanel("put my widgets here",
         radioButtons(inputId = "species",
         label = "Choose Penguin Species:",
         choices = c(
             "Adelie","Cool Chinstrap Penguins" = "Chinstrap", "Gentoo"))
                     ),
        mainPanel("Here's my main graph",
                  plotOutput(outputId = "penguin_plot"))
    )
)


# Create the server function
# Reacting subset from penguins, listens to UI. Writing it this way means that the selected penguin will be filtered for.

server <- function(input, output) {

    penguin_select <- reactive({
        penguins %>%
            filter(species == input$species)
    })

output$penguin_plot <- renderPlot({
    ggplot(data = penguin_select(), aes(x = flipper_length_mm, y =body_mass_g ))+
               geom_point()
})

}

# Combine these into an App
shinyApp(ui = ui, server = server)
