module PyPlotX

import PyPlot as plt
import PyPlot.show as plshow
import Base.display
import JLD2

export plot, plotx, plotxy, plt, load, save

mutable struct Plot
    X
    Y
    labels
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

function plotx(X, Y...; labels=nothing, fig="", title="")
    len=length(Y)
    fig_ = plt.figure(fig, figsize=(8, len*2))
    i=1
    ax=[]
    for y in Y
        subplot=100len+10+i
        push!(ax, plt.subplot(subplot))
        if i==1
            plt.suptitle(title, fontsize=14) # Super title
        end
        if ! isnothing(labels)
            lbl=labels[i]
        else
            lbl=""
        end
        plt.plot(X, y, label=lbl)
        plt.ylabel(lbl, fontsize=14);  
        plt.grid(true)
        i+=1
    end
    plt.xlabel("time [s]", fontsize=14)
    plt.xlim(0, X[end])
    plt.tight_layout()
    Plot(X, Y, labels, fig, 2)
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
    Plot(X, Y, [xlabel, ylabel], fig, 3)
end

function plot(P::Plot)
    if P.type == 1
        plot(P.X, P.Y; label=P.labels, fig=P.fig)
    elseif P.type == 2
        plotx(P.X, P.Y; labels=P.labels, fig=P.fig)
    else
        plotxy(P.X, P.Y; xlabel=P.labels[1], ylabel=P.labels[2])
    end
    nothing
end

function display(P::Plot)
    plot(P)
end

end
