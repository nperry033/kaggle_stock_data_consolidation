# kaggle_stock_data_consolidation
This script consolidates all of the files in the Huge Stock Market Dataset from Kaggle into csv files that can be imported into a database.  That dataset can be found at https://www.kaggle.com/borismarjanovic/price-volume-data-for-all-us-stocks-etfs.  Be sure to extract the compressed files first.  Also, be sure to update the paths in the script before running.  The path in the cd command should be updated to the Stocks folder under the extracted folder for the data and the path where you want the output files should also be updated towards the end of the script.

Requires the following Julia packages: DataFrames, CSV, Query, TimeSeries, Dates.
