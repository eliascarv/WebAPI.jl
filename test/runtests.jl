using WebAPI
using HTTP
using JSON3
using Test

@testset "WebAPI.jl" begin
    include("params_query.jl")
    include("req_body.jl")
    include("req_response.jl")
    include("res_constructors.jl")
    include("add_route.jl")
end
