
all: session_info eda regression dating_similar gender_bias bayes report 

report: ./report/report.Rmd ./data/*.RData ./images/*.png
	cd ./report; Rscript -e "rmarkdown::render('report.Rmd')"

bayes: ./code/functions/bayes-function.R ./data/SpeedDatingData.csv
	cd ./code/functions; Rscript bayes-function.R

gender_bias: ./code/scripts/gender-bias-script.R ./data/SpeedDatingData.csv
	cd ./code/scripts; Rscript gender-bias-script.R

dating_similar: ./code/scripts/dating-similar-script.R ./data/SpeedDatingData.csv
	cd ./code/scripts; Rscript dating-similar-script.R

regression: ./code/scripts/regression-script.R ./data/SpeedDatingData.csv
	cd ./code/scripts; Rscript regression-script.R

eda: ./code/scripts/eda-script.R ./data/SpeedDatingData.csv
	cd ./code/scripts; Rscript eda-script.R

session_info: ./code/scripts/session-info-script.R
	cd ./code/scripts; Rscript session-info-script.R

clean:
	rm -f report.pdf eda-output.txt *.RData