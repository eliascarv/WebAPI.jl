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
    
            test_url() = HTTP.get(url * "/test").status == 200
    
            @test poll(5) do
                test_url()
            end
    
            wait(@async schedule(server_task, InterruptException(); error=true))
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
    
            test_url() = HTTP.get(url * "/test").status == 200
    
            @test poll(5) do
                test_url()
            end
    
            wait(@async schedule(server_task, InterruptException(); error=true))
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
    
            test_url() = HTTP.get(url * "/test").status == 200
    
            @test poll(5) do
                test_url()
            end
    
            wait(@async schedule(server_task, InterruptException(); error=true))
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
    
            test_url() = HTTP.get(url * "/test").status == 200
    
            @test poll(5) do
                test_url()
            end
    
            wait(@async schedule(server_task, InterruptException(); error=true))
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
    
            test_url() = HTTP.get(url * "/test").status == 200
    
            @test poll(5) do
                test_url()
            end
    
            wait(@async schedule(server_task, InterruptException(); error=true))
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
    
            test_url() = HTTP.get(url * "/test").status == 200
    
            @test poll(5) do
                test_url()
            end
    
            wait(@async schedule(server_task, InterruptException(); error=true))
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

        function test_params() 
            res = HTTP.get(url * "/bhaskara/1/3/-4")
            
            json = JSON3.read(res.body)
            status = res.status

            all([json.x1 == "1.0", json.x2 == "-4.0", status == 200])
        end

        function test_query() 
            res = HTTP.get(url * "/bhaskara?a=1&b=3&c=-4")
            
            json = JSON3.read(res.body)
            status = res.status

            all([json.x1 == "1.0", json.x2 == "-4.0", status == 200])
        end

        function test_json() 
            reqjson = JSON3.write((a = 1, b = 3, c = -4))
            res = HTTP.post(url * "/bhaskara", [], reqjson)
            
            json = JSON3.read(res.body)
            status = res.status

            all([json.x1 == "1.0", json.x2 == "-4.0", status == 201])
        end

        @test poll(5) do
            test_params()
        end

        @test poll(5) do
            test_query()
        end

        @test poll(5) do
            test_json()
        end

        wait(@async schedule(server_task, InterruptException(); error=true))
    end
end