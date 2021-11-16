@testset "Add Route" begin
    @testset "Handles" begin
        app = App()

        add_get!(app, "/get") do req
            return "Test GET"
        end

        add_post!(app, "/post") do req
            return "Test POST"
        end

        add_put!(app, "/put") do req
            return "Test PUT"
        end

        add_patch!(app, "/patch") do req
            return "Test PATCH"
        end

        add_delete!(app, "/delete") do req
            return "Test DELETE"
        end

        get_req = HTTP.Request("GET", "/get")
        post_req = HTTP.Request("POST", "/post")
        put_req = HTTP.Request("PUT", "/put")
        patch_req = HTTP.Request("PATCH", "/patch")
        delete_req = HTTP.Request("DELETE", "/delete")

        get_handler = HTTP.Handlers.gethandler(app.router, get_req)
        post_handler = HTTP.Handlers.gethandler(app.router, post_req)
        put_handler = HTTP.Handlers.gethandler(app.router, put_req)
        patch_handler = HTTP.Handlers.gethandler(app.router, patch_req)
        delete_handler = HTTP.Handlers.gethandler(app.router, delete_req)

        @test get_handler.func(get_req, "") == "Test GET"
        @test post_handler.func(post_req, "") == "Test POST"
        @test put_handler.func(put_req, "") == "Test PUT"
        @test patch_handler.func(patch_req, "") == "Test PATCH"
        @test delete_handler.func(delete_req, "") == "Test DELETE"
    end

    @testset "Params and Query" begin
        app = App()

        add_get!(app, "/params/:x/:y") do req
            return Dict(req.params)
        end

        add_get!(app, "/query") do req
            return Dict(req.query)
        end

        params_req = HTTP.Request("GET", "/params/10/20")
        query_req = HTTP.Request("GET", "/query?x=10&y=20")

        params_handler = HTTP.Handlers.gethandler(app.router, params_req)
        query_handler = HTTP.Handlers.gethandler(app.router, query_req)

        @test params_handler.func(params_req, "") == Dict(:x => "10", :y => "20")
        @test query_handler.func(query_req, "") == Dict(:x => "10", :y => "20")
    end
end
