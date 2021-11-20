# Verifies if the object has keys from vector
function verifykeys(d::Union{JSON3.Object, Params, Query}, ks::AbstractVector{Symbol})
    @inbounds for i in eachindex(ks)
        haskey(d, ks[i]) || return false
    end
    return true
end

function verifykeys(d::Union{JSON3.Object, Params, Query}, ks::AbstractVector{T}) where {T<:AbstractString}
    new_ks = Symbol.(ks)
    return verifykeys(d, new_ks)
end
