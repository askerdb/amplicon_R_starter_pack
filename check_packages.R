check_packages <- function(){
  if (is.element("devtools", installed.packages()[,1]) == FALSE) {
    install.packages("devtools")
    library("devtools")
  }
  
  if (is.element('metagenomeSeq', installed.packages()[,1]) == FALSE) {
    source("http://bioconductor.org/biocLite.R")
    biocLite("metagenomeSeq")
  }
  
  if (is.element('phyloseq', installed.packages()[,1]) == FALSE) {
    install_github("phyloseq", "joey711") #Install bleeding edge of phyloseq
  }
  
  if (is.element("vegan", installed.packages()[,1]) == FALSE) {
    install.packages("vegan")
  }
  
  if (is.element("ggplot2", installed.packages()[,1]) == FALSE) {
    install.packages("ggplot2")
  }
  
  if (is.element("reshape2", installed.packages()[,1]) == FALSE) {
    install.packages("reshape2")
  }
  
}
