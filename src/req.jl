struct Params
    dict::Dict{Symbol, String}
end

Params() = Params(Dict{Symbol, String}())
Params(kv::Iterators.Zip) = Params(Dict(kv))

Base.Dict(params::Params) = copy(getfield(params, :dict))

Base.getproperty(params::Params, prop::Symbol) = getindex(getfield(params, :dict), prop)

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

Base.getproperty(query::Query, prop::Symbol) = getindex(getfield(query, :dict), prop)

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
