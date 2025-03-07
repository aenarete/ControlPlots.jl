using Pkg
if ! ("ControlSystemsBase" ∈ keys(Pkg.project().dependencies))
    using TestEnv; TestEnv.activate()
end
using ControlSystemsBase
using ControlPlots
using REPL.TerminalMenus

options = ["basic = include(\"basic.jl\")",
           "Bode_plot = include(\"bode-plot.jl\")",
           "dual_one_axis_error_bars = include(\"dual_one_axis_error_bars.jl\")",
           "dual_one_axis = include(\"dual_one_axis.jl\")",
           "dual_y_axis_3 = include(\"dual_y-axis-3.jl\")",
           "quit"]

function example_menu()
    active = true
    while active
        menu = RadioMenu(options, pagesize=8)
        choice = request("\nChoose function to execute or `q` to quit: ", menu)

        if choice != -1 && choice != length(options)
            eval(Meta.parse(options[choice]))
            # display(p)
        else
            println("Left menu. Press <ctrl><d> to quit Julia!")
            active = false
        end
    end
end

example_menu()