using ControlPlots

T = 0:0.1:2pi
X1 = sin.(T)
X2 = 0.2*sin.(2T)
Y = cos.(T)
plotx(T, [X1, X2], Y; ylabels=["sin","cos"], fig="multi-channel-dual")