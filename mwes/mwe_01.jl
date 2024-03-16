using PyPlot

fig=figure("first")
X = 0:0.1:2pi
Y = sin.(X)
p = plot(X, Y)

