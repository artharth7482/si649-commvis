library(shiny)
library(tidyverse)
library(scales)
library(MASS)
library(dplyr)
require(gridExtra)
library(plotly)

server <- function(input, output) {
  
  # Import needed csv files
  df_1 <- read.csv("data/df_1.csv", header=TRUE,)
  df_1.2 <- read.csv("data/df_1.2.csv", header=TRUE)
  df_1.3 <- read.csv("data/df_1.3.csv", header=TRUE)
  df_2 <- read.csv("data/df_2.csv", header=TRUE)
  df_3 <- read.csv("data/df_3.csv", header=TRUE)
  df_1$Medal <- factor(df_1$Medal, levels=c("Gold","Silver","Bronze"))
  
  # Create plot 1.1
  output$plot1.1 <- renderPlot({
    ggplot(df_1,aes(y=Country)) +
      geom_bar(aes(y=reorder(Country,total_medal_amount),fill=Medal),stat="count") +
      expand_limits(x = 700) +
      scale_fill_manual(values = c("#FFD700","#D3D3D3","#E5973D")) +
      geom_text(stat='count',aes(y=Country,label=..count..),
                position=position_dodge(width=1),
                hjust=-0.2) +
      labs(title="Total Medal Amount",
           x="",
           y="") +
      theme(panel.border = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank())
  })
  
  
  # Create plot 1.2
  
  
  output$plot1.2 <- renderPlot({
    ggplot(df_1.2) +
      geom_bar(stat='identity',aes(x=medal_per_capita,y=reorder(Country,medal_per_capita)),fill="lightgrey") +
      expand_limits(x = 0.0001) +
      geom_text(stat='identity',aes(x=medal_per_capita,y=Country,label=mpclabel),
                position=position_dodge(width=1),
                hjust=-0.2) +
      labs(title="Total Medal per Capita",
           x="",
           y="") +
      theme(panel.border = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            legend.position='none')
  })
  
  # Create plot 1.3
  ds1.3 <- reactive({filter(df_1.3, Country==input$input1.3)})
  
  output$plot1.3 <- renderPlot({
    ggplot(ds1.3(),aes(x=Year,y=total)) +
      geom_line(color="tomato") +
      scale_y_continuous(breaks = seq(0,100,20),limits = c(0,100)) +
      geom_text(aes(label=ranklabel),
                data = ds1.3()[ds1.3()$rank == 1,],
                position=position_dodge(width=1),
                vjust=-2,
                size=4) +
      geom_point(color="black",
                 data = ds1.3()[ds1.3()$rank == 1,]) +
      labs(title="Winter Olympics Performance overtime",
           x="",
           y="Total Medal Amount") +
      scale_x_continuous(breaks = seq(1924,2014,4),limits = c(1924,2014)) +
      theme_light() +
      theme(axis.text.x = element_text(size=10,angle=40,hjust=1))
  })
  
  # Create plot 2
  plot2.0_static <-
    ggplot(df_2) +
    geom_jitter(aes(x=HappinessScore,y=GDP,color=Country),size=2,alpha=0.4) +
    geom_text(aes(x=HappinessScore,y=GDP,label=ifelse(toHighlight==1,RankLabel,"")),size=2) +
    labs(title="GDP_per_Capita vs Happiness Score",
         x="Happiness Score",
         y="GDP_per_Capita") +
    scale_x_continuous(limits = c(3, 8.5)) +
    scale_y_continuous(limits = c(0, 120000)) +
    theme(legend.position='none')
  
  output$plot2.0 <- renderPlotly({
    ggplotly(plot2.0_static)
  })
  
  # Create plot 3
  ds3 <- reactive({df_3 %>% 
      filter(total>=input$input3.0) %>% #choose number of medals (from 2 to 11)
      group_by(Country) %>% 
      summarize(number_of_athletes=n()) %>% 
      mutate(toHighlight=ifelse(Country=="NOR","1","2"))
  })
  
  output$plot3.0 <- renderPlot({
    ggplot(ds3()) +
      geom_bar(stat='identity',aes(x=number_of_athletes,y=reorder(Country,number_of_athletes),fill=toHighlight)) +
      scale_fill_manual(values=c("tomato","lightgrey",guide=FALSE)) +
      geom_text(stat='identity',aes(x=number_of_athletes,y=Country,label=ifelse(toHighlight==1,number_of_athletes,"")),
                position=position_dodge(width=1),
                size=5,
                hjust=-0.15) +
      labs(title="Number of Athletes",
           x="",
           y="") +
      theme(panel.border = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            legend.position='none')  
  })  
}