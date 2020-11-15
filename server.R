library(tidyverse)
library(scales)
library(MASS)
library(dplyr)
require(gridExtra)

server <- shinyServer(function(input, output, session) {
  addClass(selector = "body", class = "sidebar-collapse")
})