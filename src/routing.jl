const METHODS = [
    "GET",
    "POST",
    "PUT",
    "PATCH",
    "DELETE",
    "OPTIONS",
    "HEAD"
]

for METHOD in METHODS
    add_method! = Symbol("add_$(lowercase(METHOD))!")

    @eval function $add_method!(func::Function, app::App, path::AbstractString)
        paths = URIs.splitpath(path)

        if any(startswith.(paths, ':'))
            newpaths = map(paths) do str
                startswith(str, ':') ? "*" : str
            end
            newpath = "/" * join(newpaths, "/")

            handler = (request::HTTP.Request, body) -> begin
                params = createparams(request, path)
                query = createquery(request)
                req = Req(request.method, path, params, query, body)
                return func(req)
            end

            HTTP.@register(app.router, $METHOD, newpath, handler)
        else
            handler = (request::HTTP.Request, body) -> begin
                params = Params()
                query = createquery(request)
                req = Req(request.method, request.target, params, query, body)
                return func(req)
            end

            HTTP.@register(app.router, $METHOD, path, handler)
        end

        push!(app.routelist[$METHOD], path)
        return nothing
    end
end
