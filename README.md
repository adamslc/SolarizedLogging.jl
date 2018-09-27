# SolarizedLogging

This is a simple package that replaces the default julia `ConsoleLogger` with one that
uses appropriate colors for a solarized color scheme. It reqires that your console
has 256-color support because julia prints styled text using light colors (which are
actually entirely different colors in a solarized color scheme).

## Usage
To use `SolarizedLogging`, simply use it in your `.julia/config/startup.jl` file:
```julia
using SolarizedLogging

...
```
