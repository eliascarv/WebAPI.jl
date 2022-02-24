const CORS = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "*"
]
const HEADERS_JSON = [CORS...,"Content-Type" => "application/json"]
const HEADERS_TEXT = [CORS..., "Content-Type" => "text/html"]

const JSONTypes = Union{
    Dict, NamedTuple, AbstractVector{<:Real}, 
    AbstractVector{<:Dict}, AbstractVector{<:NamedTuple}
}
const HeaderType = Vector{Pair{String, String}}

Res(body::HTTP.Response) = body

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

function Res(content_type::String, body) 
    HTTP.Response(200, [CORS..., "Content-Type" => content_type], body=string(body))
end
function Res(content_type::String, body::AbstractString)
    HTTP.Response(200, [CORS..., "Content-Type" => content_type], body=body)
end

function Res(status::Integer, content_type::String, body) 
    HTTP.Response(status, [CORS..., "Content-Type" => content_type], body=string(body))
end
function Res(status::Integer, content_type::String, body::AbstractString)
    HTTP.Response(status, [CORS..., "Content-Type" => content_type], body=body)
end

function Res(status::Integer, headers::HeaderType, body)
    HTTP.Response(status, headers, body=string(body))
end
function Res(status::Integer, headers::HeaderType, body::AbstractString)
    HTTP.Response(status, headers, body=body)
end
function Res(status::Integer, headers::HeaderType, body::JSONTypes)
    HTTP.Response(status, headers, body=JSON3.write(body))
end
