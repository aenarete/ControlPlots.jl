module ControlPlots

import PyPlot as plt
import PyPlot.show as plshow
import Base.display
import JLD2
using StaticArraysCore
using Pkg

export plot, plotx, plotxy, plot2d, plt, load, save, savefig, bode_plot

function bode_plot end

mutable struct PlotX
    X
    Y
    labels
    xlabel
    ylabels
    ysize
    yzoom
    xlims
    ylims
    ann
    scatter
    title
    fig
    type::Int64
end

function save(filename::String, p::PlotX)
    JLD2.save(filename, "plot", p)
end

function load(filename::String)
    JLD2.load(filename)["plot"]
end

include("plot.jl")
include("plotx.jl")
include("plot2d.jl")

function plotxy(X, Y; xlabel="", ylabel="", xlims=nothing, ylims=nothing, ann=nothing, 
                scatter=false, title="", fig="", ysize=14, disp=false)
    if disp
        if fig != ""
            plt.figure(fig, figsize=(6,6))
        end
        if title != ""
            plt.title(title)
        end
        plt.plot(X, Y)
        plt.xlabel(xlabel, fontsize=14);
        plt.ylabel(ylabel, fontsize=ysize);  
        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")
        plt.tight_layout()
    end
    PlotX(X, Y, nothing, xlabel, ylabel, ysize, nothing, xlims, ylims, ann, scatter, title, fig, 3)
end

function display(P::PlotX)
    if P.type == 1
        plot(P.X, P.Y; xlabel=P.xlabel, ylabel=P.ylabels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, 
             scatter=P.scatter, fig=P.fig, title=P.title, ysize=P.ysize, disp=true)
    elseif P.type == 2
        plotx(P.X, P.Y...; xlabel=P.xlabel, ylabels=P.ylabels, labels=P.labels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, 
              scatter=P.scatter, fig=P.fig, title=P.title, ysize=P.ysize, yzoom=P.yzoom, disp=true)
    elseif P.type == 3
        plotxy(P.X, P.Y; xlabel=P.xlabel, ylabel=P.ylabels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, 
               scatter=P.scatter, fig=P.fig, title=P.title, ysize=P.ysize, disp=true)
    elseif P.type == 4
        plot(P.X, P.Y; xlabel=P.xlabel, ylabel=P.ylabels, labels=P.labels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, 
             scatter=P.scatter, fig=P.fig, title=P.title, ysize=P.ysize, disp=true)
    elseif P.type == 5
        plot(P.X, P.Y[1], P.Y[2]; xlabel=P.xlabel, ylabels=P.ylabels, labels=P.labels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, 
             scatter=P.scatter, fig=P.fig, title=P.title, ysize=P.ysize, disp=true)
    end
    plt.pause(0.01)
    plt.show(block=false)
    nothing
end

function savefig(filename::String)
    plt.savefig(filename)
end

"""
    copy_examples()

Copy all example scripts to the folder "examples"
(it will be created if it doesn't exist).
"""
function copy_examples()
    PATH = "examples"
    if ! isdir(PATH) 
        mkdir(PATH)
    end
    src_path = joinpath(dirname(pathof(@__MODULE__)), "..", PATH)
    copy_files("examples", readdir(src_path))
end

function install_examples(add_packages=true)
    copy_examples()
    if add_packages
        if ! ("LaTeXStrings" ∈ keys(Pkg.project().dependencies))
            Pkg.add("LaTeXStrings")
        end
    end
end

function copy_files(relpath, files)
    if ! isdir(relpath) 
        mkdir(relpath)
    end
    src_path = joinpath(dirname(pathof(@__MODULE__)), "..", relpath)
    for file in files
        cp(joinpath(src_path, file), joinpath(relpath, file), force=true)
        chmod(joinpath(relpath, file), 0o774)
    end
    files
end

end
