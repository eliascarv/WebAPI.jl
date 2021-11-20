# Params
struct Params <: AbstractDict{Symbol, String}
    dict::Dict{Symbol, String}
end

Params() = Params(Dict{Symbol, String}())
Params(kv::Iterators.Zip) = Params(Dict(kv))
Params(kv::Pair{Symbol, String}...) = Params(Dict(kv))

# AbstractDict Interface
Base.Dict(params::Params) = copy(getfield(params, :dict))
Base.length(params::Params) = length(getfield(params, :dict))
Base.get(params::Params, args...) = get(getfield(params, :dict), args...)
Base.iterate(params::Params, args...) = iterate(getfield(params, :dict), args...)
# Personalided haskey and getindex
Base.haskey(params::Params, key::Symbol) = haskey(getfield(params, :dict), key)
Base.haskey(params::Params, key::AbstractString) = haskey(getfield(params, :dict), Symbol(key))
Base.getindex(params::Params, idx::Symbol) = getindex(getfield(params, :dict), idx)
Base.getindex(params::Params, idx::AbstractString) = getindex(getfield(params, :dict), Symbol(idx))

Base.getproperty(params::Params, prop::Symbol) = getindex(getfield(params, :dict), prop)
Base.propertynames(params::Params) = collect(keys(params))

function createparams(request::HTTP.Request, path::String)
    paths = URIs.splitpath(path)
    p_names = filter(str -> startswith(str, ':'), paths)
    p_idxs = findall(x -> x ∈ p_names, paths)
    k = map(str -> Symbol(str[2:end]), p_names)
    v = URIs.splitpath(request.target)[p_idxs]
    return Params(zip(k, v))
end

# Query
struct Query <: AbstractDict{Symbol, String}
    dict::Dict{Symbol, String}
end

Query() = Query(Dict{Symbol, String}())
Query(kv::Iterators.Zip) = Query(Dict(kv))
Query(kv::Pair{Symbol, String}...) = Query(Dict(kv))

# AbstractDict Interface
Base.Dict(query::Query) = copy(getfield(query, :dict))
Base.length(query::Query) = length(getfield(query, :dict))
Base.get(query::Query, args...) = get(getfield(query, :dict), args...)
Base.iterate(query::Query, args...) = iterate(getfield(query, :dict), args...)
# Personalided haskey and getindex
Base.haskey(query::Query, key::Symbol) = haskey(getfield(query, :dict), key)
Base.haskey(query::Query, key::AbstractString) = haskey(getfield(query, :dict), Symbol(key))
Base.getindex(query::Query, idx::Symbol) = getindex(getfield(query, :dict), idx)
Base.getindex(query::Query, idx::AbstractString) = getindex(getfield(query, :dict), Symbol(idx))

Base.getproperty(query::Query, prop::Symbol) = getindex(getfield(query, :dict), prop)
Base.propertynames(query::Query) = collect(keys(query))

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

# Req
const BodyTypes = Union{AbstractString, JSON3.Object, JSON3.Array}

struct Req{B<:BodyTypes}
    method::String
    target::String
    params::Params
    query::Query
    body::B
end
