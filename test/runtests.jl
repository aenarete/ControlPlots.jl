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
    T = 0:0.05:2pi+0.1
    POS_Z = sin.(T)
    VEL_Z = 5*cos.(T)
    p = plot(T, POS_Z, VEL_Z; 
             xlabel="time [s]", ylabels=["pos_z [m]", "vel_z [m/s]"], 
             labels=["pos_z", "vel_z"], fig="dual_y-axis")
    display(p)      
    plt.show(block=false)
    sleep(1)        
    @test p.X == T
    @test p.Y == [POS_Z, VEL_Z]
    @test p.xlabel == "time [s]"
    @test p.ylabels == ["pos_z [m]", "vel_z [m/s]"]
    @test p.labels == ["pos_z", "vel_z"]

    @testset "Plot2d" begin
        # Test standard plot2d
        pos = [[0.0, 0.0, 0.0], [1.0, 0.0, 1.0]]
        lines, sc, txt = plot2d(pos, 0.0; segments=1)
        plt.show(block=false)
        sleep(1)
        @test !isnothing(lines)
        @test length(lines) ≥ 1  # Should have at least one line
        @test !isnothing(sc)     # Should have scatter points
        @test !isnothing(txt)    # Should have time text
    end

    @testset "Plot2D with segments" begin
        # Test plot2d with segments
        points = [
            [0.0, 0.0, 2.0],  # top
            [-0.5, 0.0, 1.0], # bottom left
            [0.5, 0.0, 1.0]   # bottom right
        ]
        segments = [
            [1, 2],  # top to bottom left
            [2, 3],  # bottom left to right
            [3, 1]   # bottom right to top
        ]
        lines, sc, txt = plot2d(points, segments, 0.0)
        plt.show(block=false)
        sleep(1)
        @test !isnothing(lines)
        @test length(lines) == length(segments)  # Should have one line per segment
        @test !isnothing(sc)     # Should have scatter points
        @test !isnothing(txt)    # Should have time text
    end
end
