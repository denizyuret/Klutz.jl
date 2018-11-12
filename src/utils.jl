using BenchmarkTools

function result(bench, tool, time)
  open("results/bench.csv", "a") do io
    println(io, bench, ", ", tool, ", ", time)
  end
end

macro result(bench, tool, ex)
  quote
    t = @belapsed $ex
    result($(string(bench)), $(string(tool)), t)
  end
end
