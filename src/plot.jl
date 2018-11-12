using JuliaDB, DataFrames, IterableTables, Gadfly
using JuliaDB: groupby

data = loadtable("results/bench.csv")
data = reindex(data, :Benchmark)

baseline = filter(x->x.Package=="Baseline", data)
data = filter(x->x.Package != "Baseline", data)

normalised = join(data, baseline) do a, b
  (Package = a.Package, Time = a.Time / b.Time)
end

geomean(xs) = prod(xs)^(1/length(xs))

normalised = join(normalised, groupby(geomean, normalised, :Package, select = :Time),
                  lkey = :Package)

df = sort(DataFrame(normalised), cols = [:geomean, :Time])

p = plot(df, x = :Package, y = :Time, color = :Benchmark,
         Guide.ylabel(nothing), Guide.xlabel(nothing), Scale.y_log10)

draw(SVG(joinpath("results/benchmarks.svg"), 8inch, 8inch/1.6), p)
