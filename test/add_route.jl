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

        add_options!(app, "/options") do req
            return "Test OPTIONS"
        end

        add_head!(app, "/head") do req
            return "Test HEAD"
        end

        get_req = HTTP.Request("GET", "/get")
        post_req = HTTP.Request("POST", "/post")
        put_req = HTTP.Request("PUT", "/put")
        patch_req = HTTP.Request("PATCH", "/patch")
        delete_req = HTTP.Request("DELETE", "/delete")
        options_req = HTTP.Request("OPTIONS", "/options")
        head_req = HTTP.Request("HEAD", "/head")

        get_handler = HTTP.Handlers.gethandler(app.router, get_req)
        post_handler = HTTP.Handlers.gethandler(app.router, post_req)
        put_handler = HTTP.Handlers.gethandler(app.router, put_req)
        patch_handler = HTTP.Handlers.gethandler(app.router, patch_req)
        delete_handler = HTTP.Handlers.gethandler(app.router, delete_req)
        options_handler = HTTP.Handlers.gethandler(app.router, options_req)
        head_handler = HTTP.Handlers.gethandler(app.router, head_req)

        @test get_handler.func(get_req, "") == "Test GET"
        @test post_handler.func(post_req, "") == "Test POST"
        @test put_handler.func(put_req, "") == "Test PUT"
        @test patch_handler.func(patch_req, "") == "Test PATCH"
        @test delete_handler.func(delete_req, "") == "Test DELETE"
        @test options_handler.func(options_req, "") == "Test OPTIONS"
        @test head_handler.func(head_req, "") == "Test HEAD"
    end

    @testset "Params and Query" begin
        app = App()

        add_get!(app, "/get/:x/:y") do req
            return Dict(req.params)
        end

        add_get!(app, "/get") do req
            return Dict(req.query)
        end

        add_post!(app, "/post/:x/:y") do req
            return Dict(req.params)
        end

        add_post!(app, "/post") do req
            return Dict(req.query)
        end

        add_put!(app, "/put/:x/:y") do req
            return Dict(req.params)
        end

        add_put!(app, "/put") do req
            return Dict(req.query)
        end

        add_patch!(app, "/patch/:x/:y") do req
            return Dict(req.params)
        end

        add_patch!(app, "/patch") do req
            return Dict(req.query)
        end

        add_delete!(app, "/delete/:x/:y") do req
            return Dict(req.params)
        end

        add_delete!(app, "/delete") do req
            return Dict(req.query)
        end

        add_options!(app, "/options/:x/:y") do req
            return Dict(req.params)
        end

        add_options!(app, "/options") do req
            return Dict(req.query)
        end

        add_head!(app, "/head/:x/:y") do req
            return Dict(req.params)
        end

        add_head!(app, "/head") do req
            return Dict(req.query)
        end

        get_params_req = HTTP.Request("GET", "/get/10/20")
        get_query_req = HTTP.Request("GET", "/get?x=10&y=20")

        get_params_handler = HTTP.Handlers.gethandler(app.router, get_params_req)
        get_query_handler = HTTP.Handlers.gethandler(app.router, get_query_req)

        @test get_params_handler.func(get_params_req, "") == Dict(:x => "10", :y => "20")
        @test get_query_handler.func(get_query_req, "") == Dict(:x => "10", :y => "20")

        post_params_req = HTTP.Request("POST", "/post/10/20")
        post_query_req = HTTP.Request("POST", "/post?x=10&y=20")

        post_params_handler = HTTP.Handlers.gethandler(app.router, post_params_req)
        post_query_handler = HTTP.Handlers.gethandler(app.router, post_query_req)

        @test post_params_handler.func(post_params_req, "") == Dict(:x => "10", :y => "20")
        @test post_query_handler.func(post_query_req, "") == Dict(:x => "10", :y => "20")

        put_params_req = HTTP.Request("PUT", "/put/10/20")
        put_query_req = HTTP.Request("PUT", "/put?x=10&y=20")

        put_params_handler = HTTP.Handlers.gethandler(app.router, put_params_req)
        put_query_handler = HTTP.Handlers.gethandler(app.router, put_query_req)

        @test put_params_handler.func(put_params_req, "") == Dict(:x => "10", :y => "20")
        @test put_query_handler.func(put_query_req, "") == Dict(:x => "10", :y => "20")

        patch_params_req = HTTP.Request("PATCH", "/patch/10/20")
        patch_query_req = HTTP.Request("PATCH", "/patch?x=10&y=20")

        patch_params_handler = HTTP.Handlers.gethandler(app.router, patch_params_req)
        patch_query_handler = HTTP.Handlers.gethandler(app.router, patch_query_req)

        @test patch_params_handler.func(patch_params_req, "") == Dict(:x => "10", :y => "20")
        @test patch_query_handler.func(patch_query_req, "") == Dict(:x => "10", :y => "20")

        delete_params_req = HTTP.Request("DELETE", "/delete/10/20")
        delete_query_req = HTTP.Request("DELETE", "/delete?x=10&y=20")

        delete_params_handler = HTTP.Handlers.gethandler(app.router, delete_params_req)
        delete_query_handler = HTTP.Handlers.gethandler(app.router, delete_query_req)

        @test delete_params_handler.func(delete_params_req, "") == Dict(:x => "10", :y => "20")
        @test delete_query_handler.func(delete_query_req, "") == Dict(:x => "10", :y => "20")

        options_params_req = HTTP.Request("OPTIONS", "/options/10/20")
        options_query_req = HTTP.Request("OPTIONS", "/options?x=10&y=20")

        options_params_handler = HTTP.Handlers.gethandler(app.router, options_params_req)
        options_query_handler = HTTP.Handlers.gethandler(app.router, options_query_req)

        @test options_params_handler.func(options_params_req, "") == Dict(:x => "10", :y => "20")
        @test options_query_handler.func(options_query_req, "") == Dict(:x => "10", :y => "20")

        head_params_req = HTTP.Request("HEAD", "/head/10/20")
        head_query_req = HTTP.Request("HEAD", "/head?x=10&y=20")

        head_params_handler = HTTP.Handlers.gethandler(app.router, head_params_req)
        head_query_handler = HTTP.Handlers.gethandler(app.router, head_query_req)

        @test head_params_handler.func(head_params_req, "") == Dict(:x => "10", :y => "20")
        @test head_query_handler.func(head_query_req, "") == Dict(:x => "10", :y => "20")
    end
end
