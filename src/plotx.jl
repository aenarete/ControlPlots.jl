function plotx(X, Y...; xlabel="time [s]", ylabels=nothing, labels=nothing, xlims=nothing, ylims=nothing, ann=nothing, 
               scatter=false, fig="", title="", ysize=14, yzoom=1.0, disp=false)
    if disp
        len=length(Y)
        fig_ = plt.figure(fig, figsize=(8, len*2*yzoom))
        ax=[]
        for (i,y) in pairs(Y)
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
                if i <= length(ylabels)
                    ylbl=ylabels[i]
                else
                    ylbl=""
                end
            else
                ylbl=""
            end
            if ! isnothing(labels)
                if i <= length(labels)
                    lbl=labels[i]
                else
                    lbl=""
                end
            else
                lbl=""
            end
            for (j,yy) in pairs(y)
                if isa(yy, Vector)
                    # println("i, j: ", i, ", ", j, " lbl: ", lbl, " ", labels)
                    plt.plot(X, yy, label=lbl[j])
                else
                    # println("single: ", lbl)
                    plt.plot(X, y, label=lbl)
                    break
                end
            end
            plt.xlim(X[begin], X[end])
            plt.ylabel(ylbl; fontsize=ysize);  
            if ! isnothing(lbl) && lbl != ""
                plt.legend()
            end
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
    PlotX(collect(X), Y, labels, xlabel, ylabels, ysize, yzoom, xlims, ylims, ann, scatter, fig, 2)
end
