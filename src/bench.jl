using Pkg
cd(joinpath(@__DIR__, ".."))
Pkg.activate(".")

mkpath("results")

open("results/bench.csv", "w") do io
  println(io, "Benchmark, Package, Time")
end

j = `$(Base.julia_cmd()) -O3`

@info "Running Flux Benchmarks"
run(`$j --project=src/flux src/flux/flux.jl`)
