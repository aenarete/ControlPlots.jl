function plot2d_(pos, reltime; zoom=true, front=false, segments=6, fig="", 
                 dz_zoom= 1.5, dz=-5.0, dx=-16.0, xlim=nothing, ylim=nothing, xy=nothing, lines, sc, txt)
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
            if isnothing(xy)
                xy=(x_max, z_max+dz_zoom)
            end
            txt = plt.annotate("t=$(round(reltime,digits=1)) s",  
                xy, fontsize = 14)
            if isnothing(xlim)
                plt.xlim(x_max-15.0, x_max+5)
            else
                plt.xlim(xlim)
            end
            if isnothing(ylim)
                plt.ylim(z_max-15.0, z_max+5)
            else
                plt.ylim(ylim)
            end
        else
            if isnothing(xy)
                xy=(x_max+dx, z_max+dz)
            end
            txt = plt.annotate("t=$(round(reltime,digits=1)) s",  xy, fontsize = 14)
            if isnothing(xlim)
                plt.xlim(0, x_max+5)
            else
                plt.xlim(xlim)
            end
            if isnothing(ylim)
                plt.ylim(0, z_max+5)
            else
                plt.ylim(ylim)
            end
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
            if isnothing(xlim)
                plt.xlim(x_max-15.0, x_max+5)
            else
                plt.xlim(xlim)
            end
            if isnothing(ylim)
                plt.ylim(z_max-15.0, z_max+5)
            else
                plt.ylim(ylim)
            end
        else
            txt.set_x(x_max+dx)
            txt.set_y(z_max+dz)
            if isnothing(xlim)
                plt.xlim(0, x_max+5)
            else
                plt.xlim(xlim)
            end
            if isnothing(ylim)
                plt.ylim(0, z_max+5)
            else
                plt.ylim(ylim)
            end
        end
    end
    plt.pause(0.01)
    plt.show(block=false)
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
