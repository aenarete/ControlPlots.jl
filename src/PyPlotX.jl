module PyPlotX

import PyPlot as plt

export plot

function plot(X, Y; label="", fig="")
    if fig != ""
        plt.figure(fig)
    end
    p = plt.plot(X, Y; label)
    plt.grid(true)
    plt.tight_layout()
    p
end

end
