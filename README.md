# PyPlotExt

[![Build Status](https://github.com/aenarete/PyPlotX.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/aenarete/PyPlotX.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Introduction

This package adds the following features to the PyPlot.jl package:

- the parameters of the plot commands are stored in a struct and returned
- this struct can be displayed again or stored in a file and loaded later
- an oscilloscope-like plot with multiple channels can be created
  with the `plotx()` function
- an XY plot can be created with the `plotxy()` function

## Installation
### On Linux
First, install matplotlib:
```bash
sudo apt install python3-matplotlib
```
If not done yet, create a project:
```bash
mkdir MyProject
cd MyProject
julia --project="."
```
and install `PyPlotX`
```julia
using Pkg
pkg"add https://github.com/aenarete/PyPlotX.jl"
```

### On Windows
If not done yet, create a project:
```bash
mkdir MyProject
cd MyProject
julia --project="."
```
Install Python, matplotlib and PyPlotX
```
using Pkg
ENV["PYTHON"]=""
pkg"add https://github.com/aenarete/PyPlotX.jl"
```

## Usage

### Basic example
Lauch Julia with `julia --project`. Then execute:
```julia
using PyPlotX

X = 0:0.1:2pi
Y = sin.(X)
p = plot(X, Y, xlabel="X", ylabel="sin", fig="basic")
```
A plot window should pop up.

You can now close the plot window.
You can re-display the plot by typing:
```julia
p
```
You can also save the plot under a name of your choice:
```julia
save("plot.jld2", p)
```
Now you restart Julia and load it with:
```julia
p = load("plot.jld2")
```
The plot is automatically displayed.

### Multi-channel plot
```julia
using PyPlotX

T = 0:0.1:2pi
Y1 = sin.(T)
Y2 = cos.(T)
p = plotx(T, Y1, Y2; ylabels=["Y1", "Y2"], fig="dual")
```

### XY-Plot
```julia
using PyPlotX

T = 0:0.1:2pi+0.1
X = sin.(T)
Y = cos.(T)
p = plotxy(X, Y, xlabel="X", ylabel="Y", fig="xy")
```
