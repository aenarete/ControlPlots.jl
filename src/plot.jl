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
    PlotX(X, Y, nothing, xlabel, ylabel, ysize, xlims, ylims, ann, scatter, fig, 1)
end

