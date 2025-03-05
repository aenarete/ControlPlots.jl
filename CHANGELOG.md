### ControlPlots.jl v0.2.6 2025-03-05
#### Added
- the function `plot2d` allows now to create moving plots of any graph consisting of points and segments
- the example `plot2d-seg.jl` and tests were added

### ControlPlots.jl v0.2.5 2024-12-31
#### Added
- the function `bode_plot()` as package extension. This requires to first load the package `ControlSystemsBase` before `ControlPlots`. If you do not need this function there is no overhead.
- the example `bode_plot.jl`
- doc string for the `plotx()` function
#### Changed
- improved README.md
- improved the doc string of the `plot()` function
