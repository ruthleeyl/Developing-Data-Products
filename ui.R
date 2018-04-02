#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that calculates BMI, ideal weight based on height with the input weight and height
shinyUI(fluidPage(
  
  
  #Side Panel
  sidebarPanel(
    sliderInput('wt','Enter Your Weight (kg)',value=50,min= 20, max=200, step=0.05),
    sliderInput('ht','Enter Your Height (cm)',value=150,min= 40, max=300, step=0.05),
    submitButton("Submit")
    ),
  
  
    # Show documentation and BMI and Weight results, with a bar chart of weight comparison
    mainPanel(
      h2('Documentation on the Use of this App'),
      h5('Body Mass Index (BMI) is a simple health indicator using the height and weight of a person. The formula is BMI = Weight (kg) of a person divided by the square of his height (m).'),
      h5('This app computes your BMI, tells you whether you have a normal body weight, as well as computing your ideal weight range based on your height.'),
  h5('It calculates the amount of weight to gain if you are underweight, and the amount of weight to lose if you are overweight or obese.'),
  h5 ('Your weight versus the ideal weight based on your height will also be displayed in the chart.'),
  h5('Note that BMI is not appropriate for use as a health indicator for pregnant women, the elderly, young children and muscle-builders.'),
       
  h2('Your BMI'),
  verbatimTextOutput("bmi"),
  verbatimTextOutput("text"),
  h2('Your Ideal Weight based on Your Height'),
  h5('Minimum (kg)'),
  verbatimTextOutput('idealmin'),
  h5('Maximum (kg)'),
  verbatimTextOutput('idealmax'),
  
  plotOutput("plot1")
    )
  )
)
