using ControlPlots
x=1.5*ones(11)
y=1:0.1:2
out=min.(x,y)
plt.plot(1:11, x, label="input_a")
plt.plot(1:11, y, label="input_b")
plt.plot(1:11, out, label="output")
plt.grid(true)
plt.legend()
