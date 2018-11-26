ENV["ZYGOTE_TYPED"] = true
include("../utils.jl")

using Zygote, NNlib

const loop_iters = 500

function loop(x = 2, n = loop_iters)
  r = one(x)/one(x)
  while n > 0
    r *= sin(x)
    n -= 1
  end
  return r
end

# Ref prevents LLVM from constant folding everything away
@result loop Baseline loop(2, n = $(Ref(loop_iters))[])

@result loop Zygote gradient(loop, 2)

logreg(W, b, x) = sum(σ.(W * x .+ b))

W = randn(10,28^2)
b = randn(10)
x = rand(28^2)

@result logreg Baseline logreg($W, $b, $x)

@result logreg Zygote gradient(logreg, $W, $b, $x)
