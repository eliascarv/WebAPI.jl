using WebAPI
using HTTP
using JSON3
using Sockets
using Test

# for server tests
function bhaskara(a, b, c)
    Δ = b^2 - 4*a*c

    Δ < 0 && (Δ = complex(Δ))

    x₁ = (-b + √Δ) / 2a
    x₂ = (-b - √Δ) / 2a
    return x₁, x₂
end

@testset "WebAPI.jl" begin
    include("params_query.jl")
    include("req_body.jl")
    include("res_constructors.jl")
    include("add_route.jl")
    include("utility_functions.jl")
    include("prints.jl")
    include("server.jl")
end
