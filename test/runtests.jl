using WebAPI
using HTTP
using JSON3
using Sockets
using Test

@testset "WebAPI.jl" begin
    include("params_query.jl")
    include("req_body.jl")
    include("res_constructors.jl")
    include("add_route.jl")
    include("utility_functions.jl")
    include("prints.jl")
end
