module PyPlotX

import PyPlot as plt
import PyPlot.show as plshow
import Base.display
import JLD2

export plot, plotx, plotxy, plt, load, save

mutable struct PlotX
    X
    Y
    labels
    fig
    type::Int64
end

function save(filename::String, p::PlotX)
    JLD2.save(filename, "plot", p)
end

function load(filename::String)
    JLD2.load(filename)["plot"]
end

function plot(X, Y; label="", fig="", disp=false)
    if disp
        if fig != ""
            plt.figure(fig)
        end
        plt.plot(X, Y; label)
        plt.grid(true)
        plt.tight_layout()
    end
    PlotX(X, Y, label, fig, 1)
end

function plotx(X, Y...; labels=nothing, fig="", title="", disp=false)
    if disp
        len=length(Y)
        fig_ = plt.figure(fig, figsize=(8, len*2))
        i=1
        ax=[]
        for y in Y
            subplot=100len+10+i
            if i==1
                push!(ax, plt.subplot(subplot))
            else
                push!(ax, plt.subplot(subplot, sharex=ax[1]))
            end
            if i==1
                plt.suptitle(title, fontsize=14) # Super title
            end
            if ! isnothing(labels)
                lbl=labels[i]
            else
                lbl=""
            end
            plt.plot(X, y, label=lbl)
            plt.xlim(0, X[end])
            plt.ylabel(lbl, fontsize=14);  
            plt.grid(true)
            if i < len
                plt.setp(ax[i].get_xticklabels(), visible=false)
            end
            i+=1
        end
        plt.xlabel("time [s]", fontsize=14)
        
        plt.tight_layout()
    end
    PlotX(collect(X), Y, labels, fig, 2)
end

function plotxy(X, Y; xlabel="", ylabel="", fig="", disp=false)
    if disp
        if fig != ""
            plt.figure(fig)
        end
        plt.plot(X, Y)
        plt.xlabel(xlabel, fontsize=14);
        plt.ylabel(ylabel, fontsize=14);  
        plt.grid(true)
        plt.tight_layout()
    end
    PlotX(X, Y, [xlabel, ylabel], fig, 3)
end

function display(P::PlotX)
    if P.type == 1
        plot(P.X, P.Y; label=P.labels, fig=P.fig, disp=true)
    elseif P.type == 2
        plotx(P.X, P.Y...; labels=P.labels, fig=P.fig, disp=true)
    else
        plotxy(P.X, P.Y; xlabel=P.labels[1], ylabel=P.labels[2], disp=true)
    end
    nothing
end

end
