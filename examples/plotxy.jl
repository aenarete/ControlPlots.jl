using ControlPlots

T = 0:0.1:2pi+0.1
X = sin.(T)
Y = cos.(T)
plotxy(X, Y, fig="xy", xlabel="X", ylabel="Y")