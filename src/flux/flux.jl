include("../utils.jl")

using Flux, Flux.Tracker

const loop_iters = 500

function loop(x = 2, n = loop_iters)
  r = one(x)/one(x)
  while n > 0
    r *= sin(x)
    n -= 1
  end
  return r
end

@result loop Tracker gradient(loop, 2)

logreg(W, b, x) = sum(σ.(W * x .+ b))

W = randn(Float32, 10,28^2)
b = randn(Float32, 10)
x = rand(Float32, 28^2)

@result logreg Tracker gradient(logreg, $W, $b, $x)
