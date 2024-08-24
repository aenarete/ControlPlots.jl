"""
    plot(X, Ys::AbstractVector{<:AbstractVector}; xlabel="", ylabel="")

Plot multiple curves given by `Ys` against a common x-axis `X`.

# Arguments
- `X`: The x-axis values.
- `Ys`: A vector of vectors representing the y-axis values for each curve.

# Optional Arguments
- `xlabel`: The label for the x-axis. Default is an empty string.
- `ylabel`: The label for the y-axis. Default is an empty string.

"""
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
    PlotX(X, Ys, labels, xlabel, ylabel, ysize, nothing, xlims, ylims, ann, scatter, fig, 4)
end

function plot(X, Y1::AbstractVector{<:AbstractVector}, Y2::AbstractVector{<:Number}; 
    xlabel="", ylabels=["", ""], labels=["", ""], 
    xlims=nothing, ylims=nothing, ann=nothing, scatter=false,
    fig="", ysize=14, disp=false)
    if length(Y1) == 1
        plot(X, Y1[1], Y2; xlabel=xlabel, ylabels, labels, xlims, ylims, ann, scatter, fig, ysize, disp)
    else
        if disp
            if fig != ""
                plt.figure(fig)
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
        else
            println("OK")
        end
        PlotX(X, [Y1, Y2], labels, xlabel, ylabels, ysize, nothing, xlims, ylims, ann, scatter, fig, 5)
    end
    
end

function plot(X, Y1::AbstractVector{<:Number}, Y2::AbstractVector{<:Number}; 
              xlabel="", ylabels=["", ""], labels=["", ""], 
              xlims=nothing, ylims=nothing, ann=nothing, scatter=false,
              fig="", ysize=14, disp=false)
    local l1, l2
    if disp
        if fig != ""
            plt.figure(fig)
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
                plt.twinx()
            else
                l2, = plt.plot(X, Y; label=labels[i], color="red")
                if ylabels[2] != ""
                    plt.ylabel(ylabels[2], fontsize=ysize); 
                end
            end
        end

        plt.grid(true)
        plt.grid(which="major", color="#DDDDDD")

        lns = [l1, l2]
        plt.legend(lns, labels, loc="best")
        plt.tight_layout()
    else
        println("OK")
    end
    PlotX(X, [Y1, Y2], labels, xlabel, ylabels, ysize, nothing, xlims, ylims, ann, scatter, fig, 5)
end

function plot(Y::AbstractVector{<:Number}; xlabel="", ylabel="", fig="", ysize=14, disp=false)
    X = 1:length(Y)
    plot(X, Y; xlabel, ylabel, fig, disp, ysize)
end

function plot(X, Y::AbstractVector{<:Number}; xlabel="", ylabel="", xlims=nothing, ylims=nothing, ann=nothing, 
              scatter=false, fig="", ysize=14, disp=false)
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
    PlotX(X, Y, nothing, xlabel, ylabel, ysize, nothing, xlims, ylims, ann, scatter, fig, 1)
end

