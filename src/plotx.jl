function plotx(X, Y...; xlabel="time [s]", ylabels=nothing, xlims=nothing, ylims=nothing, ann=nothing, 
               scatter=false, fig="", title="", ysize=14, disp=false)
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
