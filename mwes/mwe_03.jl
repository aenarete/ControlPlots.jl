using ControlPlots
x = 1:10
z = 2*x

x_max = maximum(x)
z_max = maximum(z)

xlabel = "x [m]"
p=plot(x, z; xlabel, ylabel="z [m]", xlims = (x_max-15.0, x_max+5), ylims = (z_max-15.0, z_max+5))