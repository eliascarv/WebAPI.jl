@testset "Server tests" begin
    @testset "serve function" begin
        @testset "serve(app)" begin
            ip = Sockets.localhost # default ip
            port = 8081            # default port
            url = "http://$ip:$port"
            
            app = App()
            add_get!(app, "/test") do req
                "Ok"
            end
    
            server_task = @async serve(app)

            res = HTTP.get(url * "/test")

            @test String(res.body) == "Ok"
            @test res.status == 200
    
            wait(schedule(server_task, InterruptException(), error=true))
        end

        @testset "serve(app, port)" begin
            ip = Sockets.localhost # default ip
            port = 3000            
            url = "http://$ip:$port"
            
            app = App()
            add_get!(app, "/test") do req
                "Ok"
            end
    
            server_task = @async serve(app, port)
    
            res = HTTP.get(url * "/test")

            @test String(res.body) == "Ok"
            @test res.status == 200
    
            wait(schedule(server_task, InterruptException(), error=true))
        end

        @testset "serve(app, ip::AbstractString)" begin
            ip = string(getipaddr()) 
            port = 8081 # default port
            url = "http://$ip:$port"
            
            app = App()
            add_get!(app, "/test") do req
                "Ok"
            end
    
            server_task = @async serve(app, ip)
    
            res = HTTP.get(url * "/test")

            @test String(res.body) == "Ok"
            @test res.status == 200
    
            wait(schedule(server_task, InterruptException(), error=true))
        end

        @testset "serve(app, ip::IPAddr)" begin
            ip = getipaddr() 
            port = 8081 # default port
            url = "http://$ip:$port"
            
            app = App()
            add_get!(app, "/test") do req
                "Ok"
            end
    
            server_task = @async serve(app, ip)
    
            res = HTTP.get(url * "/test")

            @test String(res.body) == "Ok"
            @test res.status == 200
    
            wait(schedule(server_task, InterruptException(), error=true))
        end

        @testset "serve(app, ip::AbstractString, port)" begin
            ip = string(getipaddr()) 
            port = 3000
            url = "http://$ip:$port"
            
            app = App()
            add_get!(app, "/test") do req
                "Ok"
            end
    
            server_task = @async serve(app, ip, port)
    
            res = HTTP.get(url * "/test")

            @test String(res.body) == "Ok"
            @test res.status == 200
    
            wait(schedule(server_task, InterruptException(), error=true))
        end

        @testset "serve(app, ip::IPAddr, port)" begin
            ip = getipaddr()
            port = 3000
            url = "http://$ip:$port"
            
            app = App()
            add_get!(app, "/test") do req
                "Ok"
            end
    
            server_task = @async serve(app, ip, port)
    
            res = HTTP.get(url * "/test")

            @test String(res.body) == "Ok"
            @test res.status == 200
    
            wait(schedule(server_task, InterruptException(), error=true))
        end
    end

    @testset "Real API" begin
        ip = Sockets.localhost # default ip
        port = 8081            # default port
        url = "http://$ip:$port"

        app = App()

        add_get!(app, "/bhaskara/:a/:b/:c") do req
            a = parse(Int, req.params.a)
            b = parse(Int, req.params.b)
            c = parse(Int, req.params.c)
            x₁, x₂ = bhaskara(a, b, c)

            return Dict("x1" => "$x₁", "x2" => "$x₂")
        end

        add_get!(app, "/bhaskara") do req
            verifykeys(req.query, (:a, :b, :c)) || return Res(400, "Incorrect Query.")

            a = parse(Int, req.query.a)
            b = parse(Int, req.query.b)
            c = parse(Int, req.query.c)
            x₁, x₂ = bhaskara(a, b, c)

            return (x1 = "$x₁", x2 = "$x₂")
        end

        add_post!(app, "/bhaskara") do req
            verifykeys(req.body, ["a", "b", "c"]) || return Res(400, "Incorrect JSON.")

            a = req.body.a
            b = req.body.b
            c = req.body.c
            x₁, x₂ = bhaskara(a, b, c)

            return Res(201, (x1 = "$x₁", x2 = "$x₂"))
        end

        server_task = @async serve(app)

        # params
        res = HTTP.get(url * "/bhaskara/1/3/-4")
        json = JSON3.read(res.body)

        @test json.x1 == "1.0"
        @test json.x2 == "-4.0"
        @test res.status == 200

        # query
        res = HTTP.get(url * "/bhaskara?a=1&b=3&c=-4")
        json = JSON3.read(res.body)

        @test json.x1 == "1.0"
        @test json.x2 == "-4.0"
        @test res.status == 200

        # JSON
        reqjson = JSON3.write((a = 1, b = 3, c = -4))
        res = HTTP.post(url * "/bhaskara", [], reqjson)
        json = JSON3.read(res.body)

        @test json.x1 == "1.0"
        @test json.x2 == "-4.0"
        @test res.status == 201

        wait(schedule(server_task, InterruptException(), error=true))
    end
end