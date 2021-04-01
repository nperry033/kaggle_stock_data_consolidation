using DataFrames, CSV, Query
using TimeSeries, Dates

function pct_change(input::AbstractVector{<:Number})
    [i == 1 ? missing : (input[i]-input[i-1])/input[i-1] for i in eachindex(input)]
end

cd("/Users/perrb/Documents/Kaggle_stock_data/price-volume-data-for-all-us-stocks-etfs/Stocks")

data = convert(Matrix, CSV.read("/Users/perrb/Documents/Kaggle_stock_data/price-volume-data-for-all-us-stocks-etfs/Stocks/a.us.txt"))

data = data[:, 1:end .!= 2]
data = data[:, 1:end .!= 2]
data = data[:, 1:end .!= 2]
data = data[:, 1:end .!= 3]
data = data[:, 1:end .!= 3]

data = convert(DataFrame, data)
colnames = ["date", "price"]
names!(data, Symbol.(colnames))
symbols = ["A"]
for i in 2:size(data, 1)
    append!(symbols, ["A"])
end
data["symbol"] = symbols
permutecols!(data, [:date, :symbol, :price])

data.date = Date.(data.date)

ta = TimeArray(data)

test = data["x1"]

testval = data[2, 3]

q1 = @from i in data begin
     @where i.x1 == Date(2017, 5, 25)
     @select {i.x1, i.x2}
     @collect DataFrame
end

# We have to add row number to the master data DataFrame and use that for the
# query inside the loop instead of using dates becuase of the issue with
# weekends and holidays.

for i in 1:730
    data_add = [0.00001]
    counter = 1
    for row in eachrow(data)
        if counter == 1
            counter += 1
            continue
        end

        pc = 0.00001
        if (counter - i) >= 1
            oldPrice = data[(counter - i), 3]
            pc = (row.price - oldPrice) / oldPrice
        end
        append!(data_add, [pc])

        counter += 1
    end
    data[string(i) * "_pc"] = data_add
end

append!(master_data, data)

# Start here
master_data = DataFrame(date = Date(2020, 5, 8), symbol = "NEWSTAT", price = 69.69)
for i in 1:730
    master_data[string(i) * "_pc"] = 0.00001
end

global index = 0
for (root, dirs, files) in walkdir(".")
    for file in files
        symbol_index = findfirst(".", file)[1]
        symbol = uppercase(SubString(file, 1, (symbol_index - 1)))
        println(symbol)

        data = convert(Matrix, CSV.read(joinpath(root, file)))

        data = data[:, 1:end .!= 2]
        data = data[:, 1:end .!= 2]
        data = data[:, 1:end .!= 2]
        data = data[:, 1:end .!= 3]
        data = data[:, 1:end .!= 3]

        data = convert(DataFrame, data)
        colnames = ["date", "price"]
        names!(data, Symbol.(colnames))
        symbols = [symbol]
        for i in 2:size(data, 1)
            append!(symbols, [symbol])
        end
        data["symbol"] = symbols
        permutecols!(data, [:date, :symbol, :price])

        data.date = Date.(data.date)

        for i in 1:730
            data_add = [0.00001]
            counter = 1
            for row in eachrow(data)
                if counter == 1
                    counter += 1
                    continue
                end

                pc = 0.00001
                if (counter - i) >= 1
                    oldPrice = data[(counter - i), 3]
                    pc = (row.price - oldPrice) / oldPrice
                end
                append!(data_add, [pc])

                counter += 1
            end
            data[string(i) * "_pc"] = data_add
        end

        append!(master_data, data)

        global index += 1
        if index % 500 == 0
            println("*** Writing data ***")
            #path = "/Users/perrb/Flux/master_data_" * string(Int(floor(index / 200))) * ".csv"
            CSV.write("/Users/perrb/Flux/master_data_" * string(Int(floor(index / 200))) * ".csv", master_data, writeheader=true)

            global master_data = DataFrame(date = Date(2020, 5, 8), symbol = "NEWSTAT", price = 69.69)
            for i in 1:730
                master_data[string(i) * "_pc"] = 0.00001
            end
        end
    end
end
