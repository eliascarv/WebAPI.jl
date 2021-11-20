function add_get!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "GET", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "GET", path, handler)
    end

    push!(app.routelist["GET"], path)
    return nothing
end

function add_post!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "POST", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "POST", path, handler)
    end

    push!(app.routelist["POST"], path)
    return nothing
end

function add_put!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "PUT", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "PUT", path, handler)
    end

    push!(app.routelist["PUT"], path)
    return nothing
end

function add_patch!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "PATCH", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "PATCH", path, handler)
    end

    push!(app.routelist["PATCH"], path)
    return nothing
end

function add_delete!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "DELETE", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "DELETE", path, handler)
    end

    push!(app.routelist["DELETE"], path)
    return nothing
end

function add_options!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "OPTIONS", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "OPTIONS", path, handler)
    end

    push!(app.routelist["OPTIONS"], path)
    return nothing
end

function add_head!(func::Function, app::App, path::AbstractString)
    paths = URIs.splitpath(path)

    if any(startswith.(paths, ':'))
        new_paths = map(paths) do str
            startswith(str, ':') ? "*" : str
        end
        new_path = "/" * join(new_paths, "/")

        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = createparams(request, path)
            query = createquery(request)
            req = Req(request.method, path, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "HEAD", new_path, handler)
    else
        handler = (request::HTTP.Request, body::BodyTypes) -> begin
            params = Params()
            query = createquery(request)
            req = Req(request.method, request.target, params, query, body)
            return func(req)
        end

        HTTP.@register(app.router, "HEAD", path, handler)
    end

    push!(app.routelist["HEAD"], path)
    return nothing
end
