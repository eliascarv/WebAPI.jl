function apprunning(io::IO, app::App, ip::IPAddr, port::Int) 
    if ip == Sockets.localhost
        print(io, """

          App running at:
          http://localhost:$port/\n
        """)
    else
        print(io, """

          App running at:
          http://$ip:$port/\n
        """)
    end
    
    routetable(io, app)
end

apprunning(app::App, ip::IPAddr, port::Int) = apprunning(stdout, app, ip, port)

function parsebody(::JSONParser, req::HTTP.Request)
    body = IOBuffer(HTTP.payload(req))
    if eof(body)
        return JSON3.Object()
    else
        return JSON3.read(body)
    end
end

function parsebody(::TextParser, req::HTTP.Request)
    body = HTTP.payload(req)
    return String(body)
end

serve(app::App) = serve(app, Sockets.localhost, 8081)
serve(app::App, port::Int) = serve(app, Sockets.localhost, port)
serve(app::App, ip::IPAddr) = serve(app, ip, 8081)
serve(app::App, ip::AbstractString) = serve(app, parse(IPAddr, ip), 8081)
serve(app::App, ip::AbstractString, port::Int) = serve(app, parse(IPAddr, ip), port)

function serve(app::App, ip::IPAddr, port::Int)
    apprunning(app, ip, port)

    HTTP.serve(ip, port) do req::HTTP.Request
        req_body = parsebody(app.reqparser, req)
        res_body = HTTP.handle(app.router, req, req_body)
        return Res(res_body)
    end
end
