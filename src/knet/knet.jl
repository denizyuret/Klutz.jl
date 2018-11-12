include("../utils.jl")

using Knet

const loop_iters = 500

function loop(x = 2, n = loop_iters)
  r = one(x)/one(x)
  while n > 0
    r *= sin(x)
    n -= 1
  end
  return r
end

@result loop Knet grad(loop)(2)

using Knet

logreg(W, b, x) = sum(sigm.(W * x .+ b))

W = randn(10,28^2)
b = randn(10)
x = rand(28^2)

@result logreg Knet grad(x -> logreg(x...))(($W,$b,$x))
