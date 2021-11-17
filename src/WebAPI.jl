module WebAPI

using HTTP
using HTTP.URIs
using JSON3
using Sockets

export App, Req, Res
export JSONParser, TextParser
export add_get!, add_post!, add_put!, add_patch!, add_delete!
export serve

include("app.jl")
include("req.jl")
include("routing.jl")
include("res.jl")
include("serve.jl")

end
