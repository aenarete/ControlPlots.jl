using ControlPlots

T = 0:0.05:2pi+0.1
X = sin.(T)
Y = cos.(3T)
plotxy(X, Y, fig="xy-plot", xlabel="X", ylabel="Y")