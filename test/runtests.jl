using ControlPlots
using Test

@testset "ControlPlots.jl" begin
    X = 0:0.1:2pi
    Y = sin.(X)
    p = plot(X, Y, xlabel="X", ylabel="Y", fig="first")
    display(p)      
    plt.show(block=false)
    sleep(1)
    @test p.X == X
    @test p.Y == Y
    @test p.fig == "first"
    T = 0:0.1:2pi+0.1
    X = sin.(T)
    Y = cos.(T)
    p = plotxy(X, Y,  xlabel="X", ylabel="Y", fig="xy")
    display(p)      
    plt.show(block=false)
    sleep(1)
    @test p.X == X
    @test p.Y == Y
    @test p.fig == "xy"
    T = 0:0.1:2pi
    Y1 = sin.(T)
    Y2 = cos.(T)
    p = plotx(T, Y1, Y2; ylabels=["Y1", "Y2"], fig="dual")
    display(p)      
    plt.show(block=false)
    sleep(1)
    @test p.X == T
    @test p.Y == (Y1, Y2)
    @test p.xlabel == "time [s]"
    @test p.ylabels == ["Y1", "Y2"]
end
