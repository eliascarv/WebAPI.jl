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

serve(app) #Deafult: ip = localhost, port = 8081
```

More complex example:
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

add_get!(app, "/bhaskara/:a/:b/:c") do req
    a = parse(Int, req.params.a)
    b = parse(Int, req.params.b)
    c = parse(Int, req.params.c)
    x₁, x₂ = bhaskara(a, b, c)

    return Dict("x1" => "$x₁", "x2" => "$x₂")
end

add_get!(app, "/bhaskara") do req
    verifykeys(req.query, (:a, :b, :c)) || return Res(400, "Incorrect Query.")

    a = parse(Int, req.query.a)
    b = parse(Int, req.query.b)
    c = parse(Int, req.query.c)
    x₁, x₂ = bhaskara(a, b, c)

    return (x1 = "$x₁", x2 = "$x₂")
end

add_post!(app, "/bhaskara") do req
    verifykeys(req.body, ["a", "b", "c"]) || return Res(400, "Incorrect JSON.")

    a = req.body.a
    b = req.body.b
    c = req.body.c
    x₁, x₂ = bhaskara(a, b, c)

    return Res(201, (x1 = "$x₁", x2 = "$x₂"))
end

serve(app) #Deafult: ip = localhost, port = 8081
```
The above code running:
```
  App running at:
  http://localhost:8081/

  Method           Route
  ==============================================

  POST             /bhaskara
  GET              /bhaskara/:a/:b/:c
  GET              /bhaskara
```
Testing the API:
```julia
julia> using HTTP, JSON3

julia> r = HTTP.get("http://localhost:8081/bhaskara/1/3/-4")
HTTP.Messages.Response:
"""
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: *
Access-Control-Allow-Methods: *
Content-Type: application/json
Transfer-Encoding: chunked

{"x1":"1.0","x2":"-4.0"}"""

julia> JSON3.read(r.body)
JSON3.Object{Vector{UInt8}, Vector{UInt64}} with 2 entries:
  :x1 => "1.0"
  :x2 => "-4.0"

julia> r = HTTP.get("http://localhost:8081/bhaskara?a=1&b=3&c=-4")
HTTP.Messages.Response:
"""
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: *
Access-Control-Allow-Methods: *
Content-Type: application/json
Transfer-Encoding: chunked

{"x1":"1.0","x2":"-4.0"}"""

julia> JSON3.read(r.body)
JSON3.Object{Vector{UInt8}, Vector{UInt64}} with 2 entries:
  :x1 => "1.0"
  :x2 => "-4.0"

julia> json = JSON3.write((a = 1, b = 3, c = -4))
"{\"a\":1,\"b\":3,\"c\":-4}"

julia> r = HTTP.post("http://localhost:8081/bhaskara", [], json)
HTTP.Messages.Response:
"""
HTTP/1.1 201 Created
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: *
Access-Control-Allow-Methods: *
Content-Type: application/json
Transfer-Encoding: chunked

{"x1":"1.0","x2":"-4.0"}"""

julia> JSON3.read(r.body)
JSON3.Object{Vector{UInt8}, Vector{UInt64}} with 2 entries:
  :x1 => "1.0"
  :x2 => "-4.0"
```