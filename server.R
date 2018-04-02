#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

BMI<- function(wt,ht) wt/(ht/100)^2

# Define server logic required to compute BMI, amount of weight to lose/gain to reach normal body weight
# computes ideal weight based on height and draws a bar chart of weight comparison 
shinyServer(function(input, output) {

  output$bmi<- renderPrint({BMI(input$wt,input$ht)})
  
  tt <- reactive({
  if(BMI(input$wt,input$ht)<18.5){
    wtmin<-18.5*(input$ht/100)^2-input$wt
    wtmax<-24.9*(input$ht/100)^2-input$wt
    text<-sprintf("You are underweight. Please gain %.2f to %.2f kg to reach a normal body weight.", wtmin, wtmax)
    }else if(BMI(input$wt,input$ht)<25) {
      text<-"You have a normal body weight. Continue to maintain this weight."
    }else if(BMI(input$wt,input$ht)<30){
      wtmin<-input$wt-18.5*(input$ht/100)^2
      wtmax<-input$wt-24.9*(input$ht/100)^2
      text<-sprintf("You are overweight. Please try to lose %.2f to %.2f kg to reach a normal body weight.", wtmax,wtmin)
    }else if(BMI(input$wt,input$ht)>30){
      wtmin<-input$wt- 18.5*(input$ht/100)^2
      wtmax<-input$wt- 24.9*(input$ht/100)^2
      text<-sprintf("You are obese. You should try to lose %.2f to %.2f kg to reach a normal body weight.", wtmax,wtmin)
    }
  })
  
  observe({
    input$wt
    input$ht
  })
  
  output$text<-renderText(tt())
  
  output$idealmin<-renderText({
    18.5*(input$ht/100)^2
  })
     
  output$idealmax<-renderText({
    24.8*(input$ht/100)^2
  })
  output$plot1 <- renderPlot({
    
    counts<-c(input$wt,18.5*(input$ht/100)^2, 24.9*(input$ht/100)^2)
    x = c("Your Weight", "Ideal Weight (Min)", "Ideal Weight (Max)")
   barplot(counts,horiz = FALSE,names.arg = x,col = c("red","blue","blue"),main="Your Weight vs Ideal Weight based on Your Height")
   abline(h=input$wt,col="red",lwd=2,lty=2)
   
  })
  
})
