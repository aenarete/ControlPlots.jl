using ControlPlots
x   = 1.5*ones(11)
y   = 1:0.1:2
out = min.(x,y)
plot(1:11, [x,y,out]; labels=["input_a", "input_b", "output"], fig="2-in-one")
