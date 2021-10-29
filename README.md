# WebAPI.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://eliascarv.github.io/WebAPI.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://eliascarv.github.io/WebAPI.jl/dev)
[![Build Status](https://github.com/eliascarv/WebAPI.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/eliascarv/WebAPI.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/eliascarv/WebAPI.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/eliascarv/WebAPI.jl)

WebAPI.jl is a abstraction of two Julia packages: HTTP.jl and JSON3.jl.
These abstractions allow you to develop APIs in Julia in a simpler and more readable way.

Example:
```julia
using WebAPI

function bhaskara(a, b, c)
    Δ = b^2 - 4*a*c

    Δ < 0 && (Δ = Complex(Δ))

    x₁ = (-b + √Δ) / 2a
    x₂ = (-b - √Δ) / 2a
    return x₁, x₂
end

const app = App()

add_post!(app, "/bhaskara") do req
    a = req.body.a
    b = req.body.b
    c = req.body.c
    x₁, x₂ = bhaskara(a, b, c)

    return Dict("x1" => "$x₁", "x2" => "$x₂")
end

serve(app)
```