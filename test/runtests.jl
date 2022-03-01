using WebAPI
using HTTP
using JSON3
using Sockets
using Test

function bhaskara(a, b, c)
    Δ = b^2 - 4*a*c

    Δ < 0 && (Δ = complex(Δ))

    x₁ = (-b + √Δ) / 2a
    x₂ = (-b - √Δ) / 2a
    return x₁, x₂
end

function poll(query::Function, timeout::Real=Inf64, interval::Real=1/20)
    start = time()
    while time() < start + timeout
        if query()
            return true
        end
        sleep(interval)
    end
    return false
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
