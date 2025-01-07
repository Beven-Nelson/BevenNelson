library(shiny)
library(ggplot2)

# Define server logic required to draw plots
shinyServer(function(input, output) {
  
  # Trend Plot 1: Histogram
  output$p1 <- renderPlot({
    ggplot(mtcars, aes_string(x = input$continuous_variable)) +
      geom_histogram(bins = input$bins, fill = "blue", color = "white") +
      theme_minimal() +
      labs(
        title = "Histogram of Continuous Variable",
        x = input$continuous_variable,
        y = "Count"
      )
  })
  
  # Trend Plot 2: Boxplot
  output$p2 <- renderPlot({
    # Convert the categorical variable to a factor explicitly
    mtcars[[input$categorical_variable]] <- factor(mtcars[[input$categorical_variable]])
    
    ggplot(mtcars, aes_string(x = input$categorical_variable, y = input$continuous_variable)) +
      geom_boxplot(fill = "orange", color = "black") +
      theme_minimal() +
      labs(
        title = "Boxplot of Continuous vs Categorical Variables",
        x = input$categorical_variable,
        y = input$continuous_variable
      )
  })
  
  # Correlation Plot (Dynamic continuous variable)
  output$p3 <- renderPlot({
    # Convert the categorical variable to a factor explicitly
    mtcars[[input$categorical_variable]] <- factor(mtcars[[input$categorical_variable]])
    ggplot(mtcars, aes_string(x = input$continuous_variable, y = input$other_continuous_variable,color=input$categorical_variable)) +
      geom_point(shape=19) +
      theme_minimal() +
      labs(
        title = "Correlation Plot",
        x = input$continuous_variable,
        y = input$other_continuous_variable
      )
  })
  
  # Subdivision Plot: Pie Chart
  output$p4 <- renderPlot({
    # Count occurrences of each level in the selected categorical variable
    data <- table(mtcars[[input$categorical_variable]])
    data <- as.data.frame(data)
    colnames(data) <- c("category", "count")  # Rename columns for clarity
    
    # Create the pie chart
    ggplot(data, aes(x = "", y = count, fill = category)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y") +
      labs(
        title = paste("Pie Chart: Subdivision of", input$categorical_variable),
        fill = input$categorical_variable
      ) +
      theme_void()  # Simplify the theme for a cleaner pie chart
  })
})
