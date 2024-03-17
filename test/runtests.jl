using PyPlotX
using Test

@testset "PyPlotX.jl" begin
    X = 0:0.1:2pi
    Y = sin.(X)
    p = plot(X, Y, fig="first")
    display(p)      
    plt.show(block=false)
    sleep(1)
    @test p.X == X
    @test p.Y == Y
    @test p.fig == "first"
    T = 0:0.1:2pi+0.1
    X = sin.(T)
    Y = cos.(T)
    p = plotxy(X, Y, fig="xy")
    display(p)      
    plt.show(block=false)
    sleep(1)
    @test p.X == X
    @test p.Y == Y
    @test p.fig == "xy"
end
