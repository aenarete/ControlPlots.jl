module PyPlotX

import PyPlot as plt
import PyPlot.show as plshow
import Base.display
import JLD2

export plot, plt, load, save

mutable struct Plot
    X
    Y
    label
    fig
end

function save(filename::String, p::Plot)
    JLD2.save(filename, "plot", p)
end

function load(filename::String)
    JLD2.load(filename)["plot"]
end

function plot(X, Y; label="", fig="")
    if fig != ""
        plt.figure(fig)
    end
    p = plt.plot(X, Y; label)
    plt.grid(true)
    plt.tight_layout()
    Plot(X, Y, label, fig)
end

function plot(P::Plot)
    plot(P.X, P.Y; label=P.label, fig=P.fig)
    nothing
end

function display(P::Plot)
    plot(P)
end

end
