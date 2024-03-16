module PyPlotX

import PyPlot as plt
import PyPlot.show as plshow
import Base.display

export plot, plt, plshow

mutable struct Plot
    X
    Y
    label
    fig
end

function plot(X, Y; label="", fig="")
    if fig != ""
        plt.figure(fig)
    end
    p = plt.plot(X, Y; label)
    plt.grid(true)
    plt.tight_layout()
    Plot(X, Y, label, fig)
end

function plot(P::Plot)
    plot(P.X, P.Y; label=P.label, fig=P.fig)
    nothing
end

function display(P::Plot)
    plot(P)
end

end
