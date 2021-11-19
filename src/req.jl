struct Params
    dict::Dict{Symbol, String}
end

Params() = Params(Dict{Symbol, String}())
Params(kv::Iterators.Zip) = Params(Dict(kv))

Base.Dict(params::Params) = copy(getfield(params, :dict))
Base.keys(params::Params) = keys(getfield(params, :dict))
Base.values(params::Params) = values(getfield(params, :dict))
Base.haskey(params::Params, key::Symbol) = haskey(getfield(params, :dict), key)
Base.haskey(params::Params, key::AbstractString) = haskey(getfield(params, :dict), Symbol(key))

Base.getproperty(params::Params, prop::Symbol) = getindex(getfield(params, :dict), prop)

Base.getindex(params::Params, idx::Symbol) = getindex(getfield(params, :dict), idx)
Base.getindex(params::Params, idx::AbstractString) = getindex(getfield(params, :dict), Symbol(idx))

function createparams(request::HTTP.Request, path::String)
    paths = URIs.splitpath(path)
    p_names = filter(str -> startswith(str, ':'), paths)
    p_idxs = findall(x -> x ∈ p_names, paths)
    k = map(str -> Symbol(str[2:end]), p_names)
    v = URIs.splitpath(request.target)[p_idxs]
    return Params(zip(k, v))
end


struct Query
    dict::Dict{Symbol, String}
end

Query() = Query(Dict{Symbol, String}())
Query(kv::Iterators.Zip) = Query(Dict(kv))

Base.Dict(query::Query) = copy(getfield(query, :dict))
Base.keys(query::Query) = keys(getfield(query, :dict))
Base.values(query::Query) = values(getfield(query, :dict))
Base.haskey(query::Query, key::Symbol) = haskey(getfield(query, :dict), key)
Base.haskey(query::Query, key::AbstractString) = haskey(getfield(query, :dict), Symbol(key))

Base.getproperty(query::Query, prop::Symbol) = getindex(getfield(query, :dict), prop)

Base.getindex(query::Query, idx::Symbol) = getindex(getfield(query, :dict), idx)
Base.getindex(query::Query, idx::AbstractString) = getindex(getfield(query, :dict), Symbol(idx))

function createquery(request::HTTP.Request)
    dict = queryparams(URI(request.target))
    if isempty(dict)
        return Query()
    else
        k = Symbol.(keys(dict))
        v = values(dict)
        return Query(zip(k, v))
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
