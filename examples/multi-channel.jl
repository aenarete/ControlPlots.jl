using PyPlotX

T = 0:0.1:2pi
X = sin.(T)
Y = cos.(T)
p = plotx(T, X, Y; labels=["sin","cos"], fig="2-chan");