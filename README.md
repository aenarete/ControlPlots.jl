# PyPlotX

[![Build Status](https://github.com/aenarete/PyPlotX.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/aenarete/PyPlotX.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Introduction

This package adds the following features to the PyPlot.jl package:

- the result of a plot command is stored in a struct
- this struct can be displayed again or stored in a file and loaded later
- an oscilloscope-like plot with multiple channels can be created
  with the `plotx()` function
- an XY plot can be created with the `plotxy()` function

## Installation
### On Linux
First, install matplotlib:
```
sudo apt install python3-matplotlib
```
If not done yet, create a project:
```
mkdir MyProject
cd MyProject
julia --project="."
```
and install `PyPlotX`
```
using Pkg
pkg"add PyPlotX"
```

## Usage

Simple example:
```
using PyPlotX

X = 0:0.1:2pi
Y = sin.(X)
p = plot(X, Y);
```
A plot window should pop up.

You can now close the plot window.
You can re-display the plot by typing:
```
p
```
