struct Params
    dict::Dict{Symbol, String}
end

Params() = Params(Dict{Symbol, String}())

function Base.getproperty(params::Params, prop::Symbol)
    if prop == :dict
        return getfield(params, :dict)
    end
    return getindex(getfield(params, :dict), prop)
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
    dict::Dict{Symbol, String}
end

Query() = Query(Dict{Symbol, String}())

function Base.getproperty(query::Query, prop::Symbol)
    if prop == :dict
        return getfield(query, :dict)
    end
    return getindex(getfield(query, :dict), prop)
end

function createquery(request::HTTP.Request)
    dict = queryparams(URI(request.target))
    if isempty(dict)
        return Query()
    else
        return Query(Dict( zip(Symbol.(keys(dict)), values(dict)) ))
    end
end


const BodyTypes = Union{String, JSON3.Object, JSON3.Array}

struct Req{B<:BodyTypes}
    method::String
    target::String
    params::Params
    query::Query
    body::B
end
