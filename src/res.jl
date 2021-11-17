const HEADERS_JSON = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "*",
    "Content-Type" => "application/json"
]

const HEADERS_TEXT = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "*",
    "Content-Type" => "text/html"
]

const JSONTypes = Union{Dict, NamedTuple, AbstractVector{<:Real}, AbstractVector{<:Dict}, AbstractVector{<:NamedTuple}}
const HeaderType = Vector{Pair{String, String}}

Res(status::Integer) = HTTP.Response(status)
Res(headers::HeaderType) = HTTP.Response(200, headers)

Res(body) = HTTP.Response(200, HEADERS_TEXT, body=string(body))
Res(body::AbstractString) = HTTP.Response(200, HEADERS_TEXT, body=body)
Res(body::JSONTypes) = HTTP.Response(200, HEADERS_JSON, body=JSON3.write(body))

Res(status::Integer, headers::HeaderType) = HTTP.Response(status, headers)

Res(status::Integer, body) = HTTP.Response(status, HEADERS_TEXT, body=string(body))
Res(status::Integer, body::AbstractString) = HTTP.Response(status, HEADERS_TEXT, body=body)
Res(status::Integer, body::JSONTypes) = HTTP.Response(status, HEADERS_JSON, body=JSON3.write(body))

Res(headers::HeaderType, body) = HTTP.Response(200, headers, body=string(body))
Res(headers::HeaderType, body::AbstractString) = HTTP.Response(200, headers, body=body)
Res(headers::HeaderType, body::JSONTypes) = HTTP.Response(200, headers, body=JSON3.write(body))

function Res(status::Integer, headers::HeaderType, body)
    return HTTP.Response(status, headers, body=string(body))
end
function Res(status::Integer, headers::HeaderType, body::AbstractString)
    return HTTP.Response(status, headers, body=body)
end
function Res(status::Integer, headers::HeaderType, body::JSONTypes)
    return HTTP.Response(status, headers, body=JSON3.write(body))
end
