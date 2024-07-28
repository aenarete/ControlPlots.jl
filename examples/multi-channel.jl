using ControlPlots

T = 0:0.1:2pi
X = sin.(T)
Y = cos.(T)
plotx(T, X, Y; ylabels=["sin","cos"], fig="multi-channel")