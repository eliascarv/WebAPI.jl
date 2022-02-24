# Params
struct Params <: AbstractDict{Symbol, String}
    dict::Dict{Symbol, String}
end

Params() = Params(Dict{Symbol, String}())
Params(kv::Iterators.Zip) = Params(Dict(kv))
Params(kv::Pair{Symbol, String}...) = Params(Dict(kv))

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

const ParamsOrQuery = Union{Params, Query}

# AbstractDict Interface
Base.Dict(pq::ParamsOrQuery) = copy(getfield(pq, :dict))
Base.length(pq::ParamsOrQuery) = length(getfield(pq, :dict))
Base.get(pq::ParamsOrQuery, key::Symbol, default) = get(getfield(pq, :dict), key, default)
Base.get(pq::ParamsOrQuery, key::AbstractString, default) = get(getfield(pq, :dict), Symbol(key), default)
Base.get(f::Base.Callable, pq::ParamsOrQuery, key::Symbol) = get(f, getfield(pq, :dict), key)
Base.get(f::Base.Callable, pq::ParamsOrQuery, key::AbstractString) = get(f, getfield(pq, :dict), Symbol(key))
Base.iterate(pq::ParamsOrQuery, args...) = iterate(getfield(pq, :dict), args...)
# Calling faster haskey and getindex methods defined for Dict type
Base.haskey(pq::ParamsOrQuery, key::Symbol) = haskey(getfield(pq, :dict), key)
Base.haskey(pq::ParamsOrQuery, key::AbstractString) = haskey(getfield(pq, :dict), Symbol(key))
Base.getindex(pq::ParamsOrQuery, idx::Symbol) = getindex(getfield(pq, :dict), idx)
Base.getindex(pq::ParamsOrQuery, idx::AbstractString) = getindex(getfield(pq, :dict), Symbol(idx))
# params.key and query.key syntax
Base.getproperty(pq::ParamsOrQuery, prop::Symbol) = getindex(getfield(pq, :dict), prop)
Base.propertynames(pq::ParamsOrQuery) = collect(keys(pq))

# Req
const BodyTypes = Union{AbstractString, JSON3.Object, JSON3.Array}

struct Req{B<:BodyTypes}
    method::String
    target::String
    params::Params
    query::Query
    body::B
end
