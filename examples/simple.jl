using PyPlotExt

X = 0:0.1:2pi
Y = sin.(X)
p = plot(X, Y)
nothing