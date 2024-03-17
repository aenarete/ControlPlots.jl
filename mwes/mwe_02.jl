using JLD2

mutable struct PlotX
    X
    Y
end

function test(X, Y...)
    len=length(Y)
    println(len)
    println(typeof(Y))
    PlotX(X, Y)
end

T = 0:0.1:2pi
X = sin.(T)
Y = cos.(T)
p1 = test(T, X, Y);
p2 = test(p1.X, p1.Y...);
nothing
