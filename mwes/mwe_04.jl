# for reprducing bug in ControlPlots
# run this once, close the plot window, then run it again
# --> crash

using ControlPlots
plot2d([[1,0,0], [2,0,0]], 0; segments=1)
nothing
