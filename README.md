# kaggle_stock_data_consolidation
This script consolidates all of the files in the Huge Stock Market Dataset from Kaggle into csv files that can be imported into a database.  That dataset can be found at https://www.kaggle.com/borismarjanovic/price-volume-data-for-all-us-stocks-etfs.  Be sure to extract the compressed files first.  Also, be sure to update the paths in the script before running.  The path in the cd command should be updated to the Stocks folder under the extracted folder for the data and the path where you want the output files should also be updated towards the end of the script.

The goal of the consolidation is to ultimately import the files into a database so all of the data is in one table with a column for symbol.  Also, to calculate percent change for 730 trading days backwards.  This allows us to train models to find patterns in the pricing, easily calculate average volatility for a stock over a certain time frame, easily calculate volatility trends in the market, and more.  The 730 trading days back can also be adjusted in the script to better suit your needs.

Requires the following Julia packages: DataFrames, CSV, TimeSeries, Dates.
