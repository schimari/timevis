## timevis timeline
# https://github.com/daattali/timevis

library("timevis")
library("plotly")
library("htmlwidgets")
library("webshot")

home <- getwd()
folder <- "plots"
datafile <- read.table("data/Urothelkarzinom-Mainz_2016_08_29.txt", sep="\t", header=T, stringsAsFactors = F, na.strings="")

# cleaning and setting data
data_tr <- datafile	#[,c(1:50)]

colnames(data_tr) <- c("Name", "Vorname", "E.Nr.1", "E.Nr.1.Datum", "E.Nr.1.T.Klass", "E.Nr.1.Grading",
					"E.Nr.2", "E.Nr.2.Datum", "E.Nr.2.T.Klass", "E.Nr.2.Grading", "E.Nr.3", "E.Nr.3.Datum",
					"E.Nr.3.T.Klass", "E.Nr.3.Grading", "E.Nr.4", "E.Nr.4.Datum", "E.Nr.4.T.Klass", "E.Nr.4.Grading",
					"E.Nr.5", "E.Nr.5.Datum", "E.Nr.5.T.Klass", "E.Nr.5.Grading", "E.Nr.6", "E.Nr.6.Datum",    
					"E.Nr.6.T.Klass", "E.Nr.6.Grading", "E.Nr.7", "E.Nr.7.Datum", "E.Nr.7.T.Klass", "E.Nr.7.Grading",  
					"E.Nr.8", "E.Nr.8.Datum", "E.Nr.8.T.Klass", "E.Nr.8.Grading", "E.Nr.9", "E.Nr.9.Datum",    
					"Ei.Nr.9.T.Klass", "E.Nr.9.Grading", "E.Nr.10", "E.Nr.10.Datum", "E.Nr.10.T.Klass", "E.Nr.10.Grading", 
					"E.Nr.11", "E.Nr.11.Datum", "E.Nr.11.T.Klass", "E.Nr.11.Grading", "E.Nr.12", "E.Nr.12.Datum",   
					"E.Nr.12.T.Klass", "E.Nr.12.Grading")
						
# set dates
data_tr$E.Nr.1.Datum <- as.Date(data_tr$E.Nr.1.Datum, format="%d.%m.%Y")
data_tr$E.Nr.2.Datum <- as.Date(data_tr$E.Nr.2.Datum, format="%d.%m.%Y")
data_tr$E.Nr.3.Datum <- as.Date(data_tr$E.Nr.3.Datum, format="%d.%m.%Y")
data_tr$E.Nr.4.Datum <- as.Date(data_tr$E.Nr.4.Datum, format="%d.%m.%Y")
data_tr$E.Nr.5.Datum <- as.Date(data_tr$E.Nr.5.Datum, format="%d.%m.%Y")
data_tr$E.Nr.6.Datum <- as.Date(data_tr$E.Nr.6.Datum, format="%d.%m.%Y")
data_tr$E.Nr.7.Datum <- as.Date(data_tr$E.Nr.7.Datum, format="%d.%m.%Y")
data_tr$E.Nr.8.Datum <- as.Date(data_tr$E.Nr.8.Datum, format="%d.%m.%Y")
data_tr$E.Nr.9.Datum <- as.Date(data_tr$E.Nr.9.Datum, format="%d.%m.%Y")
data_tr$E.Nr.10.Datum <- as.Date(data_tr$E.Nr.10.Datum, format="%d.%m.%Y")
data_tr$E.Nr.11.Datum <- as.Date(data_tr$E.Nr.11.Datum, format="%d.%m.%Y")
data_tr$E.Nr.12.Datum <- as.Date(data_tr$E.Nr.12.Datum, format="%d.%m.%Y")

# get rid of extra spaces and umlauts
data_tr$Name <- gsub(" ", "", data_tr$Name)
data_tr$Name <- gsub("ü", "ue", data_tr$Name)
data_tr$Name <- gsub("ö", "oe", data_tr$Name)
data_tr$Name <- gsub("ä", "ae", data_tr$Name)
data_tr$Name <- gsub("Ü", "Ue", data_tr$Name)
data_tr$Name <- gsub("Ö", "Oe", data_tr$Name)
data_tr$Name <- gsub("Ä", "Ae", data_tr$Name)

data_tr$Vorname <- gsub(" ", "", data_tr$Vorname)
data_tr$Vorname <- gsub("ü", "ue", data_tr$Vorname)
data_tr$Vorname <- gsub("ö", "oe", data_tr$Vorname)
data_tr$Vorname <- gsub("ä", "ae", data_tr$Vorname)
data_tr$Vorname <- gsub("Ü", "Ue", data_tr$Vorname)
data_tr$Vorname <- gsub("Ö", "Oe", data_tr$Vorname)
data_tr$Vorname <- gsub("Ä", "Ae", data_tr$Vorname)

# create group df
group_df <- data.frame(id=1:nrow(data_tr), content=sprintf("%s, %s", data_tr$Name, data_tr$Vorname))

for (i in 1:nrow(data_tr)) {
	data_df <- data.frame(
		# TODO: ifelse Grading is NA use only Klass and vice versa
		content = c(paste(data_tr[i,]$E.Nr.1.T.Klass, data_tr[i,]$E.Nr.1.Grading, sep=" - "), 
			paste(data_tr[i,]$E.Nr.2.T.Klass, data_tr[i,]$E.Nr.2.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.3.T.Klass, data_tr[i,]$E.Nr.3.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.4.T.Klass, data_tr[i,]$E.Nr.4.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.5.T.Klass, data_tr[i,]$E.Nr.5.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.6.T.Klass, data_tr[i,]$E.Nr.6.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.7.T.Klass, data_tr[i,]$E.Nr.7.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.8.T.Klass, data_tr[i,]$E.Nr.8.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.9.T.Klass, data_tr[i,]$E.Nr.9.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.10.T.Klass, data_tr[i,]$E.Nr.10.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.11.T.Klass, data_tr[i,]$E.Nr.11.Grading, sep=" - "),
			paste(data_tr[i,]$E.Nr.12.T.Klass, data_tr[i,]$E.Nr.12.Grading, sep=" - ")
			),
		start = c(data_tr[i,]$E.Nr.1.Datum,
			data_tr[i,]$E.Nr.2.Datum,
			data_tr[i,]$E.Nr.3.Datum,
			data_tr[i,]$E.Nr.4.Datum,
			data_tr[i,]$E.Nr.5.Datum,
			data_tr[i,]$E.Nr.6.Datum,
			data_tr[i,]$E.Nr.7.Datum,
			data_tr[i,]$E.Nr.8.Datum,
			data_tr[i,]$E.Nr.9.Datum,
			data_tr[i,]$E.Nr.10.Datum,
			data_tr[i,]$E.Nr.11.Datum,
			data_tr[i,]$E.Nr.12.Datum
			),
		group = i
	)
	p_data <- data_df[!is.na(data_df$start),]
	p_plot <- timevis(p_data, fit=TRUE, showZoom=FALSE, groups=group_df[i,])
	setwd(folder)
	fname <- sprintf("%s_%s.html", data_tr[i,]$Name, data_tr[i,]$Vorname)
	saveWidget(p_plot, file = fname, selfcontained = FALSE)
	webshot(url=fname, file=sprintf("pdf/%s.pdf", gsub(".html", "", fname)))
	setwd(home)
}

# crop pdf-files and merge into one in linux with script: crop.pdf.sh





########################

#> data
#  id     content               start        end
#1  1    Item one          2016-01-10       <NA>
#2  2    Item two          2016-01-11       <NA>
#3  3 Ranged item          2016-01-20 2016-02-04
#4  4   Item four 2016-02-14 15:00:00       <NA>