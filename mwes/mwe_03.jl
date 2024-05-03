using ControlPlots
x = 1:10
z = 2*x

x_max = maximum(x)
z_max = maximum(z)

xlabel = "x [m]"
reltime = 0.0
ann = (x_max-10.0, z_max-3.0, "t=$(round(reltime,digits=1)) s")
p=plot(x, z; xlabel, ylabel="z [m]", xlims = (x_max-15.0, x_max+5), ylims = (z_max-15.0, z_max+5), ann, scatter=true)