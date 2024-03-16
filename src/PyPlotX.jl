module PyPlotX

import PyPlot as plt
import PyPlot.show as plshow
import Base.display
import JLD2

export plot, plotxy, plt, load, save

mutable struct Plot
    X
    Y
    label
    fig
    type::Int64
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
    plt.plot(X, Y; label)
    plt.grid(true)
    plt.tight_layout()
    Plot(X, Y, label, fig, 1)
end

function plotxy(X, Y; xlabel="", ylabel="", fig="")
    if fig != ""
        plt.figure(fig)
    end
    plt.plot(X, Y)
    plt.xlabel(xlabel, fontsize=14);
    plt.ylabel(ylabel, fontsize=14);  
    plt.grid(true)
    plt.tight_layout()
    Plot(X, Y, [xlabel, ylabel], fig, 2)
end

function plot(P::Plot)
    if P.type == 1
        plot(P.X, P.Y; label=P.label, fig=P.fig)
    else
        plotxy(P.X, P.Y; xlabel=P.label[1], ylabel=P.label[2])
    end
    nothing
end

function display(P::Plot)
    plot(P)
end

end
