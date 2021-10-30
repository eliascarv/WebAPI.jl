abstract type AbstractParser end

struct JSONParser <: AbstractParser end

struct TextParser <: AbstractParser end

struct App{T, P<:AbstractParser}
    router::HTTP.Router{T}
    reqparser::P
    routelist::Dict{String, Vector{String}}
end

function App(; reqparser::AbstractParser = JSONParser())
    router = HTTP.Router()
    routelist = Dict(
        "GET" => Vector{String}(),
        "POST" => Vector{String}(),
        "PUT" => Vector{String}(),
        "PATCH" => Vector{String}(),
        "DELETE" => Vector{String}(),
        "OPTIONS" => Vector{String}(),
        "HEAD" => Vector{String}()
    )
    return App(router, reqparser, routelist)
end
