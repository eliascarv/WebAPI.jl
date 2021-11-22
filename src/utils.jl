const AbstractStringOrSymbol = Union{AbstractString, Symbol}

# Verifies if the object has keys from vector
function verifykeys(
    d::Union{JSON3.Object, Params, Query}, 
    ks::AbstractVector{T}
) where {T<:AbstractStringOrSymbol}
    @inbounds for i in eachindex(ks)
        haskey(d, ks[i]) || return false
    end
    return true
end
