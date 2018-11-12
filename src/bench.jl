using Pkg
cd(joinpath(@__DIR__, ".."))
Pkg.activate(".")

mkpath("results")

open("results/bench.csv", "w") do io
  println(io, "Benchmark, Package, Time")
end

j = `$(Base.julia_cmd()) -O3`

@info "Running Baseline Benchmarks"
run(`$j --project=src/baseline src/baseline/baseline.jl`)

@info "Running Flux Benchmarks"
run(`$j --project=src/flux src/flux/flux.jl`)

@info "Running Knet Benchmarks"
run(`$j --project=src/knet src/knet/knet.jl`)

@info "Running Zygote Benchmarks"
run(`$j --project=src/zygote src/zygote/zygote.jl`)
