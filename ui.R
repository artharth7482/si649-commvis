library(shiny)
library(tidyverse)
library(scales)
library(MASS)
library(dplyr)
require(gridExtra)
library(plotly)

ui <- fluidPage(
  titlePanel(title=h1("Why is Norway doing so well in Winter Olympics 🇳🇴", align='center')),
  h4("written by Hua-Shao Liao", align='center'),
  
  hr(),    
  
  br(),  
  h3("OVERVIEW 👀"),
  p("Starting from 1924, 23 Winter Olympics were hold. During these 94 years, more than 120 countries have participated in this major international event. Among these 127 countries, you probably notice that Norway - a country with around 5 million population (ranked 119th in the world) has done a extremely great job in the Winter Olympics."),
  p("In the following graphs, you can see that Norway won 443 medals in total from 1924 to 2014, and ranked No.3 in the world (see left graph). However, when we consider each country's population, Norway beats all counties (see right graph). What's more, according to statistic, 1 out of 11724 Norwegian wins an Olympic medal. That's crazy, right?"),
  br(),
  fluidRow(
    column(6,
           plotOutput("plot1.1"),
    ),
    column(6, 
           plotOutput("plot1.2"),
    )),
  br(),
  p("Besides Norway's overall performance, let's take a closer look on its performance overtime. In the graph below, you can see that Norway has a pretty consistent performance overtime and it won most medals three times, which only falls behind the United State."),
  p("💡Tips: use dropdown menu to select a country and see the change of the plot on the right",align='center'),
  br(),
  fluidRow(
    column(3, offset = 0.5,
           selectInput("input1.3","Choose a country:",c("United States"="USA","Canada"="CAN","Norway"="NOR","Sweden"="SWE","Finland"="FIN","Germany"="GER","Australia"="AUT","Switzerland"="SUI","Russia"="RUS","Italy"="ITA")),
    ),
    column(9, 
           plotOutput("plot1.3"),
    )),
  br(),
  
  hr(),
  
  br(),    
  h3("BUT WHY 🤔"),
  p("Many articles reported that Norwegian athletes are more chill than other countries'. Another reason could be that Norwegians are richer. Wealth could affect lots of other factors, such as athletes' health, number of sports facilities in the country, practice tools they use, etc. The following plot shows that Norway rank No.2 in Happiness Score and rank No.3 in GDP_per_Capita among the world. In fact, most of the top 10 medal winning countries have hight Happiness Score and GDP_per_Capita."),
  p("💡Tips: click the graph to enable the interactions.",align='center'),
  p("💡Tips: hover on each data point to see what country it is and corresponding stats.",align='center'),
  br(),
  plotlyOutput("plot2.0"),
  br(),  
  
  hr(),
  
  br(),  
  h3("WHAT'S MORE 🔥"),
  p("In fact, the unique athletes rates among Norwegian medalists is lower than other countries. And guess what, Norwegian athletes seem to be more likely to win more medals in their careers. The following plot allows you to discover how great Norwegian athletes are."),
  p("💡Tips: adjust the number by clicking the up and down arrows on the right and see the change of the plot",align='center'),
  br(),
  fluidRow(
    column(3, offset=0.5,
           numericInput("input3.0","Won not less than # medals in their careers:",3,min=2,max=11),
    ),
    column(9,
           plotOutput("plot3.0"),
    )),
  br(),
  p("Thanks for reading! Hope you have a better understanding of how and why Norway is doing so well in Winter Olympics. Let's look forward to Norway's performance in next game ⛷️"),
  br(),
  hr(),
  
  
)