rmarkdown::render("R/chris_card.rmd", output_file = "../goodbye_chris")
viewer <- getOption("viewer")
viewer("goodbye_chris.html")
