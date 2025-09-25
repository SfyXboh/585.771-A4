# Asignment 4
Submit an HTML or PDF export of your hw4.ipnyb file. Also submit your .R code. Before exporting, select "Restart & Run All" to make sure all code runs cleanly and outputs are displayed.

* Create the opioid sqlite database from https://smart-stats.github.io/ds4bio_book/book/_build/html/sqlite.html. However, only go to the step where the csv files are read into the database. Then exit sqlite and you should have a file opioid.db that has the data. Next, read the three tables into pandas dataframes and do the remaining data wrangling from the sqlite chapter directly in pandas. Add the python code to your hw4.ipynb file.
* Create a scatterplot of the average number of opioid pills by year by loading the sql database in python. [See the example here](https://www.opencasestudies.org/ocs-bp-opioid-rural-urban/#Data_Import). Don't do the intervals (little vertical lines), only the points.
* Repeat the steps of loading and merging the opioid data files in R. That is, follow the steps of loading and merging the three csv files as well as the data cleaning described in the notes in R.
* Take your R code from the previous step and call it from python instead of R. Convert the resulting dataset to a pandas dataframe.

You should have an ipython notebook as well as an R file or ipython notebook executed with an R runtime instead of python.
