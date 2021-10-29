struct Params
    p::Dict{Symbol, String}
end

Params() = Params(Dict{Symbol, String}())

function Base.getproperty(params::Params, prop::Symbol)
    if prop in (:p,)
        getfield(params, :p)
    end
    return getindex(getfield(params, :p), prop)
end

function createparams(request::HTTP.Request, path::String)
    paths = URIs.splitpath(path)
    p_names_str = filter(str -> startswith(str, ':'), paths)
    p_positions = findall(x -> x ∈ p_names_str, paths)
    p_names = map(str -> Symbol(str[2:end]), p_names_str)
    p_values = URIs.splitpath(request.target)[p_positions]
    return Params(Dict(zip(p_names, p_values)))
end


struct Query
    q::Dict{Symbol, String}
end

Query() = Query(Dict{Symbol, String}())

function Base.getproperty(query::Query, prop::Symbol)
    if prop in (:q,)
        getfield(query, :q)
    end
    return getindex(getfield(query, :q), prop)
end

function createquery(request::HTTP.Request)
    dict = queryparams(URI(request.target))
    if isempty(dict)
        return Query()
    else
        return Query(Dict( zip(Symbol.(keys(dict)), values(dict)) ))
    end
end


const BodyTypes = Union{String, JSON3.Object}

struct Req{B<:BodyTypes}
    method::String
    target::String
    params::Params
    query::Query
    body::B
end
