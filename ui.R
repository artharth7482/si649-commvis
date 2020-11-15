library(shiny)
library(shinyjs)

# Import CSV & prepare dataset
df <- read.csv("mydata.csv", header=TRUE, na.strings=c("","NA"))
top_ten <- c("USA","CAN","NOR","SWE","FIN","GER","AUT","SUI","RUS","ITA")
df$Medal <- factor(df$Medal, levels=c("Gold","Silver","Bronze")) #reorder the level of Medal

dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    useShinyjs()
  )
))