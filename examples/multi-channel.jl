using PyPlotX

T = 0:0.1:2pi
X = sin.(T)
Y = cos.(T)
p = plotx(collect(T), X, Y);