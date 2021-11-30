const AbstractStringOrSymbol = Union{AbstractString, Symbol}

# Verifies if the object has keys from vector
function verifykeys( 
    d::Union{JSON3.Object, Params, Query}, 
    ks::Union{Tuple{Vararg{T}}, AbstractVector{T}}
) where {T<:AbstractStringOrSymbol} 
    return all(k -> haskey(d, k), ks)
end
