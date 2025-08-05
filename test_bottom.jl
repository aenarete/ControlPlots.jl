using ControlPlots

# Test the new bottom parameter
T = 0:0.1:2π
Y1 = sin.(T)
Y2 = cos.(T)

# Test plotx without bottom parameter (should work as before)
p1 = plotx(T, Y1, Y2; ylabels=["sin", "cos"], fig="test1", title="Without bottom parameter")
display(p1)

# Test plotx with bottom parameter
p2 = plotx(T, Y1, Y2; ylabels=["sin", "cos"], fig="test2", title="With bottom parameter", bottom=0.15)
display(p2)

println("bottom parameter value in p1: ", p1.bottom)
println("bottom parameter value in p2: ", p2.bottom)
