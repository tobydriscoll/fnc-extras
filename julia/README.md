# Julia codes

These Julia codes are replacements for the MATLAB codes in _Fundamentals of Numerical Computation_ by Driscoll and Braun.

## Overview

The codes are broken into two groups: functions, designated as such by the text and provided in source code files, and chapter-by-chapter examples, which correspond to Examples in the text and are provided as Jupyter notebooks. 

The functions are not bundled as a Julia package, as they are for pedagogical rather than production uses. 

## Viewing examples

You can see the example results as static HTML files from the links in [examples.html](examples.html).  As of February 2019, everything here runs in Julia 1.0 and 1.1. 

You can also [view the examples as notebooks](https://nbviewer.jupyter.org/github/tobydriscoll/fnc-extras/tree/master/julia/) using nbviewer. 

## Running examples in the browser

You should be able to run the examples without installing anything by visiting this binder:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tobydriscoll/fnc-extras/master?filepath=julia%2F)

Be patient with this option, as performance does not appear to be very good, especially when loading Julia packages. Also, the animations do not render.  

## Running examples locally 

*Advanced users:* If you don't want to change your default Julia environment, you can `Pkg.instantiate` this directory to cleanly get the necessary packages. However, you will need to do so anew for every Julia session. 

The examples and (to a lesser extent) functions are dependent on Julia packages that do not ship with the standard distribution. You must use `Pkg.add` once to add each of them to a Julia environment. You can find which ones are needed in the [Project.toml](Project.toml) file of this directory, or you can just add them as you get error messages about them. 

To make the functions available within a Julia session, enter `include("FNC.jl")` (adding in the path as needed). This will create a module called `FNC` that imports all the functions. All invocations of the functions must be qualified with the module name, as shown in the examples. 
