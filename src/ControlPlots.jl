module ControlPlots

import PyPlot as plt
import PyPlot.show as plshow
import Base.display
import JLD2

export plot, plotx, plotxy, plot2d, plt, load, save

mutable struct PlotX
    X
    Y
    labels
    xlabel
    ylabels
    ysize
    xlims
    ylims
    ann
    scatter
    fig
    type::Int64
end

function save(filename::String, p::PlotX)
    JLD2.save(filename, "plot", p)
end

function load(filename::String)
    JLD2.load(filename)["plot"]
end

function plot(X, Ys::AbstractVector{<:AbstractVector}; xlabel="", ylabel="",
              labels=nothing, xlims=nothing, ylims=nothing, ann=nothing, scatter=false, fig="", ysize=14, disp=false)
    if disp
        if fig != ""
            plt.figure(fig)
        end
        for (i, Y) in pairs(Ys)
            if isnothing(labels)
                plt.plot(X, Y)
            else
                if isnothing(labels[i]) || labels[i]==""
                    plt.plot(X, Y)
                else
                    plt.plot(X, Y; label=labels[i])
                end
            end
        end
        if xlabel != ""
            plt.xlabel(xlabel, fontsize=14); 
        end
        if ylabel != ""
            plt.ylabel(ylabel, fontsize=ysize); 
        end
        if ! isnothing(xlims)
            println("xlims: $xlims")
            plt.xlim(xlims)
        end
        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")
        plt.legend()
        plt.tight_layout()
    else
        println("OK")
    end
    PlotX(X, Ys, labels, xlabel, ylabel, ysize, xlims, ylims, ann, scatter, fig, 4)
end

function plot(Y::AbstractVector{<:Number}; xlabel="", ylabel="", fig="", ysize=14, disp=false)
    X = 1:length(Y)
    plot(X, Y; xlabel, ylabel, fig, disp, ysize)
end

function plot(X, Y::AbstractVector{<:Number}; xlabel="", ylabel="", xlims=nothing, ylims=nothing, ann=nothing, scatter=false, fig="", ysize=14, disp=false)
    if disp
        if fig != ""
            plt.figure(fig)
        end
        plt.plot(X, Y; label=ylabel)
        if xlabel != ""
            plt.xlabel(xlabel, fontsize=14); 
        end
        plt.ylabel(ylabel; fontsize=ysize);
        if isnothing(xlims)
            plt.xlim(X[begin], X[end])
        else
            plt.xlim(xlims)
        end
        if ! isnothing(ylims)
            plt.ylim(ylims)
        end
        if ! isnothing(ann)
            plt.annotate(ann[3],  xy=(ann[1], ann[2]), fontsize = 14)
        end
        if scatter
            plt.scatter(X, Y; s=24, c="red", alpha=1)
        end
        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")
        plt.tight_layout()
    end
    PlotX(X, Y, nothing, xlabel, ylabel, ysize, xlims, ylims, ann, scatter, fig, 1)
end

function plotx(X, Y...; xlabel="time [s]", ylabels=nothing, xlims=nothing, ylims=nothing, ann=nothing, scatter=false, fig="", title="", ysize=14, disp=false)
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
                plt.suptitle(title; fontsize=14) # Super title
            end
            if ! isnothing(ylabels)
                lbl=ylabels[i]
            else
                lbl=""
            end
            plt.plot(X, y, label=lbl)
            plt.xlim(X[begin], X[end])
            plt.ylabel(lbl; fontsize=ysize);  
            plt.grid(true)
            plt.grid(which="major", color="#DDDDDD")
            if i < len
                plt.setp(ax[i].get_xticklabels(), visible=false)
            end
            i+=1
        end
        plt.xlabel(xlabel, fontsize=14)
        
        plt.tight_layout()
    end
    PlotX(collect(X), Y, nothing, xlabel, ylabels, ysize, xlims, ylims, ann, scatter, fig, 2)
end

function plotxy(X, Y; xlabel="", ylabel="", xlims=nothing, ylims=nothing, ann=nothing, scatter=false, fig="", ysize=14, disp=false)
    if disp
        if fig != ""
            plt.figure(fig, figsize=(6,6))
        end
        plt.plot(X, Y)
        plt.xlabel(xlabel, fontsize=14);
        plt.ylabel(ylabel, fontsize=ysize);  
        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")
        plt.tight_layout()
    end
    PlotX(X, Y, nothing, xlabel, ylabel, ysize, xlims, ylims, ann, scatter, fig, 3)
end

function display(P::PlotX)
    if P.type == 1
        plot(P.X, P.Y; xlabel=P.xlabel, ylabel=P.ylabels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, scatter=P.scatter, fig=P.fig, ysize=P.ysize, disp=true)
    elseif P.type == 2
        plotx(P.X, P.Y...; xlabel=P.xlabel, ylabels=P.ylabels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, scatter=P.scatter, fig=P.fig, ysize=P.ysize, disp=true)
    elseif P.type == 3
        plotxy(P.X, P.Y; xlabel=P.xlabel, ylabel=P.ylabels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, scatter=P.scatter, fig=P.fig, ysize=P.ysize, disp=true)
    else
        plot(P.X, P.Y; xlabel=P.xlabel, ylabel=P.ylabels, labels=P.labels, xlims=P.xlims, ylims=P.ylims, ann=P.ann, scatter=P.scatter, fig=P.fig, ysize=P.ysize, disp=true)
    end
    plt.pause(0.01)
    plt.show(block=false)
    nothing
end

function plot2d_(pos, reltime; zoom=true, front=false, segments=6, fig="", dz_zoom= 1.5, dz=-5.0, dx=-16.0, lines, sc, txt)
    x = Float64[] 
    z = Float64[]
    for i in eachindex(pos)
        if front
            push!(x, pos[i][2])
        else
            push!(x, pos[i][1])
        end
        push!(z, pos[i][3])
    end
    x_max = maximum(x)
    z_max = maximum(z)
    xlabel = "x [m]"
    if front xlabel = "y [m]" end
    if isnothing(lines)
        if fig != ""
            plt.figure(fig)
        end
        lines=[]
        line, = plt.plot(x,z; linewidth="1")
        push!(lines, line)
        sc  = plt.scatter(x, z; s=25, color="red") 
        if zoom
            txt = plt.annotate("t=$(round(reltime,digits=1)) s",  
                xy=(x_max, z_max+dz_zoom), fontsize = 14)
            plt.xlim(x_max-15.0, x_max+5)
            plt.ylim(z_max-15.0, z_max+5)
        else
            txt = plt.annotate("t=$(round(reltime,digits=1)) s",  
            xy=(x_max+dx, z_max+dz), fontsize = 14)
            plt.xlim(0, x_max+5)
            plt.ylim(0, z_max+5)
        end
        if length(pos) > segments+1
            s=segments
            line, = plt.plot([x[s+1],x[s+4]],[z[s+1],z[s+4]], linewidth="1"); push!(lines, line) # S6
            line, = plt.plot([x[s+2],x[s+5]],[z[s+2],z[s+5]], linewidth="1"); push!(lines, line) # S8
            line, = plt.plot([x[s+3],x[s+5]],[z[s+3],z[s+5]], linewidth="1"); push!(lines, line) # S7
            line, = plt.plot([x[s+2],x[s+4]],[z[s+2],z[s+4]], linewidth="1"); push!(lines, line) # S2
            line, = plt.plot([x[s+1],x[s+5]],[z[s+1],z[s+5]], linewidth="1"); push!(lines, line) # S5
        end
        plt.xlabel(xlabel, fontsize=14)
        plt.ylabel("z [m]", fontsize=14)
        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")
        display(plt.gcf())
    else
        lines[1].set_xdata(x)
        lines[1].set_ydata(z)
        if length(pos) > segments+1
            s=segments
            lines[2].set_xdata([x[s+1],x[s+4]]) # S6
            lines[2].set_ydata([z[s+1],z[s+4]]) # S6
            lines[3].set_xdata([x[s+2],x[s+5]]) # S8
            lines[3].set_ydata([z[s+2],z[s+5]]) # S8
            lines[4].set_xdata([x[s+3],x[s+5]]) # S7
            lines[4].set_ydata([z[s+3],z[s+5]]) # S7
            lines[5].set_xdata([x[s+2],x[s+4]]) # S2
            lines[5].set_ydata([z[s+2],z[s+4]]) # S2
            lines[6].set_xdata([x[s+1],x[s+5]]) # S5
            lines[6].set_ydata([z[s+1],z[s+5]]) # S5
        end
        sc.set_offsets(hcat(x,z))
        # xy=(x_max, z_max+8.0)
        txt.set_text("t=$(round(reltime,digits=1)) s")
        if zoom
            txt.set_x(x_max)
            txt.set_y(z_max+dz_zoom)
            plt.xlim(x_max-15.0, x_max+5)
            plt.ylim(z_max-15.0, z_max+5)
        else
            txt.set_x(x_max+dx)
            txt.set_y(z_max+dz)
            plt.xlim(0, x_max+5)
            plt.ylim(0, z_max+5)
        end
        plt.gcf().canvas.draw()
    end
    sleep(0.01)
    lines, sc, txt
end

plot2d = let lines = nothing, sc = nothing, txt = nothing  # Note: Must all be on same line as let!
    function(pos, reltime=0.0; kwargs...)
        if reltime == 0.0
            lines, sc, txt = nothing, nothing, nothing
        end
        lines, sc, txt = plot2d_(pos, reltime; lines, sc, txt, kwargs...)
    end
end


end
