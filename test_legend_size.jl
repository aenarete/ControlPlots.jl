using ControlPlots

# Test the legend_size parameter
T = 0:0.1:2π
Y1 = sin.(T)
Y2 = cos.(T)

# Test plotx with default legend_size
p1 = plotx(T, [Y1, Y2]; ylabels=["Channel 1"], labels=[["sin", "cos"]], fig="test1", title="Default legend size")
display(p1)

# Test plotx with custom legend_size
p2 = plotx(T, [Y1, Y2]; ylabels=["Channel 1"], labels=[["sin", "cos"]], fig="test2", title="Large legend size", legend_size=16)
display(p2)

println("legend_size parameter value in p1: ", p1.legend_size)
println("legend_size parameter value in p2: ", p2.legend_size)
