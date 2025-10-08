"""
    plot(X, Ys::AbstractVector{<:Union{AbstractVector, Tuple}}; xlabel="", ylabel="",
    labels=nothing, xlims=nothing, ylims=nothing, ann=nothing, scatter=false, 
    title="", fig="", ysize=14, disp=false)

Plot multiple curves given by `Ys` against a common x-axis `X`.

# Arguments
- `X`: The x-axis values.
- `Ys`: A vector of vectors representing the y-axis values for each curve.

# Optional Arguments
- `xlabel`: The label for the x-axis. Default is an empty string.
- `ylabel`: The label for the y-axis. Default is an empty string.
- `labels`: The labels for each curve. Default is `nothing`.
- `xlims`: The limits for the x-axis. Default is `nothing`.
- `ylims`: The limits for the y-axis. Default is `nothing`.
- `ann`: An annotation to be placed on the plot. Default is `nothing`.
- `scatter`: A boolean indicating whether to plot the points as a scatter plot. Default is `false`.
- `title`: The title of the figure. Default is an empty string.
- `fig`: The name of the figure. Default is an empty string.
- `ysize`: The font size for the y-axis label. Default is 14.
- `disp`: A boolean indicating whether to display the plot. If false, only create a structure to be displayed later. 
          Default is `false`.
"""
function plot(X, Ys::AbstractVector{<:Union{AbstractVector, Tuple}}; xlabel="", ylabel="",
    labels=nothing, xlims=nothing, ylims=nothing, ann=nothing, scatter=false, 
    title="", fig="", ysize=14, disp=false)
    if disp
        if fig != ""
            plt.figure(fig)
        end
        if title != ""
            plt.title(title)
        end
        for (i, YT) in pairs(Ys)
            if YT isa Tuple
                Y, Yerr = YT
                if isnothing(Yerr)
                    YT = Y
                end
            end
            if YT isa Tuple
                Y, Yerr = YT
                if isnothing(labels)
                    plt.errorbar(X, Y, yerr=Yerr, capsize=5)
                else
                    if isnothing(labels[i]) || labels[i]==""
                        plt.errorbar(X, Y, yerr=Yerr, capsize=5)
                    else
                        plt.errorbar(X, Y, yerr=Yerr; label=labels[i], capsize=5)
                    end
                end
                if scatter
                    plt.scatter(X, Y; s=24, c="red", alpha=1)
                end
            else
                Y = YT
                if isnothing(labels)
                    plt.plot(X, Y)
                else
                    if isnothing(labels[i]) || labels[i]==""
                        plt.plot(X, Y)
                    else
                        plt.plot(X, Y; label=labels[i])
                    end
                end
                if scatter
                    plt.scatter(X, Y; s=24, c="red", alpha=1)
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
            plt.xlim(xlims)
        end
        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")
        plt.legend()
        plt.tight_layout()
    end
    PlotX(X, Ys, labels, xlabel, ylabel, ysize, nothing, nothing, nothing, xlims, ylims, ann, scatter, title, fig, nothing, 4)
end

function plot(X, Y1::AbstractVector{<:AbstractVector}, Y2::AbstractVector{<:Number}; 
    xlabel="", ylabels=["", ""], labels=["", ""], 
    xlims=nothing, ylims=nothing, ann=nothing, scatter=false,
    title="", fig="", ysize=14, disp=false)
    if length(Y1) == 1
        plot(X, Y1[1], Y2; xlabel=xlabel, ylabels, labels, xlims, ylims, ann, scatter, title, fig, ysize, disp)
    else
        if disp
            if fig != ""
                plt.figure(fig)
            end
            if title != ""
                plt.title(title)
            end
            colors=["green", "grey", "red"]
            lns = []
            for (i, Y) in pairs(Y1)
                ln, = plt.plot(X, Y; label=labels[i], color=colors[i])
                push!(lns, ln)
                if i==1 && xlabel != ""
                    plt.xlabel(xlabel, fontsize=14);                     
                    if ylabels != ["", ""]
                        plt.ylabel(ylabels[1], fontsize=ysize); 
                    end
                end
            end
            plt.twinx()
            ln, = plt.plot(X, Y2; label=labels[3], color=colors[end])
            push!(lns, ln)
            plt.ylabel(ylabels[2], fontsize=ysize); 
            plt.grid(true)
            plt.grid(which="major", color="#DDDDDD")
            plt.legend(lns, labels, loc="best")
            plt.tight_layout()
        end
        PlotX(X, [Y1, Y2], labels, xlabel, ylabels, ysize, nothing, nothing, nothing, xlims, ylims, ann, scatter, title, fig, nothing, 5)
    end
    
end

function plot(X, Y1::AbstractVector{<:Number}, Y2::AbstractVector{<:Number}; 
              xlabel="", ylabels=["", ""], labels=["", ""], 
              xlims=nothing, ylims=nothing, ann=nothing, scatter=false,
              title="", fig="", ysize=14, disp=false)
    local l1, l2
    if disp
        if fig != ""
            plt.figure(fig)
        end
        if title != ""
            plt.title(title)
        end
        if labels == ["", ""]
            labels = ylabels
        end
        for (i, Y) in pairs([Y1, Y2])
            
            if i==1
                l1, = plt.plot(X, Y; label=labels[i], color="green")
                if xlabel != ""
                    plt.xlabel(xlabel, fontsize=14); 
                end
                if ylabels != ["", ""]
                    plt.ylabel(ylabels[1], fontsize=ysize); 
                end
                if ! isnothing(ylims)
                    plt.ylim(ylims[1])
                end
                if scatter
                    plt.scatter(X, Y; s=24, c="red", alpha=1)
                end
                plt.twinx()
            else
                l2, = plt.plot(X, Y; label=labels[i], color="red")
                if ylabels[2] != ""
                    plt.ylabel(ylabels[2], fontsize=ysize); 
                end
                if ! isnothing(ylims)
                    plt.ylim(ylims[2])
                end
                if scatter
                    plt.scatter(X, Y; s=24, c="red", alpha=1)
                end
            end
        end

        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")

        lns = [l1, l2]
        plt.legend(lns, labels, loc="best")
        plt.tight_layout()
    end
    PlotX(X, [Y1, Y2], labels, xlabel, ylabels, ysize, nothing, nothing, nothing, xlims, ylims, ann, scatter, title, fig, nothing, 5)
end

function plot(Y::AbstractVector{<:Number}; xlabel="", ylabel="", title="", fig="", ysize=14, disp=false)
    X = collect(eachindex(Y))
    plot(X, Y; xlabel, ylabel, title, fig, disp, ysize)
end

function plot(X, Y::AbstractVector{<:Number}; xlabel="", ylabel="", xlims=nothing, ylims=nothing, ann=nothing, 
              scatter=false, title="", fig="", ysize=14, disp=false)
    if disp
        if fig != ""
            plt.figure(fig)
        end
        if title != ""
            plt.title(title)
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
    PlotX(X, Y, nothing, xlabel, ylabel, ysize, nothing, nothing, nothing, xlims, ylims, ann, scatter, title, fig, nothing, 1)
end

