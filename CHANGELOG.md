### ControlPlots.jl v0.2.10 2025-10-08
#### Changed
- do not print OK when calling plot any longer
- document the use of the fig parameter with the function plot2d

### ControlPlots.jl v0.2.9 2025-08-21
#### Added
- the `plotx` function now supports an optional `legend_size` parameter to control the font size of the legend (default: 10 points)
- the `plotx` function now supports an optional `loc` parameter to control the legend location (default: "best")
- the `PlotX` struct now includes `legend_size` and `loc` fields to store these legend parameters
#### Changed
- updated documentation in README.md to include the new `legend_size` and `loc` parameters
- the `plt.legend()` call in `plotx` now uses the `legend_size` and `loc` parameters for better legend customization

### ControlPlots.jl v0.2.8 2025-08-05
#### Added
- the `plotx` function now supports an optional `bottom` parameter to control the bottom margin of the plot using `plt.tight_layout(rect=[0, bottom, 1, 1])`
- the `PlotX` struct now includes a `bottom` field to store the bottom margin parameter
#### Changed
- updated documentation in README.md to include the new `bottom` parameter

### ControlPlots.jl v0.2.7 2025-03-08
#### Added
- all plot functions have now the optional parameter `title`
- the script `menu.jl` was added
- the function `ControlPlots.install_examples()` was added
#### Changed
- README.md was updated

### ControlPlots.jl v0.2.6 2025-03-05
#### Added
- the function `plot2d` allows now to create moving plots of any graph consisting of points and segments
- the example `plot2d-seg.jl` and tests were added
#### Changed
- README.md was updated

### ControlPlots.jl v0.2.5 2024-12-31
#### Added
- the function `bode_plot()` as package extension. This requires to first load the package `ControlSystemsBase` before `ControlPlots`. If you do not need this function there is no overhead.
- the example `bode_plot.jl`
- doc string for the `plotx()` function
#### Changed
- improved README.md
- improved the doc string of the `plot()` function
