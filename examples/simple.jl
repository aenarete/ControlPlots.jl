using ControlPlots

X = 0:0.1:2pi
Y = sin.(X)
p=plot(X, Y; title="Simple plot")