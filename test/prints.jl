@testset "Prints" begin
    @testset "routetable" begin
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        iostr = sprint(WebAPI.routetable, app)

        str = """
          Method        Route
          ==============================================
          POST          test
        """

        @test iostr == str
    end

    @testset "App show" begin
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        iostr = sprint(show, app)

        str = """
        App with reqparser = JSONParser and routes:\n
          Method        Route
          ==============================================
          POST          test
        """

        @test iostr == str
    end

    @testset "apprunning" begin
        # localhost
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        iostr = sprint(WebAPI.apprunning, app, Sockets.localhost, 80)

        str = """

          App running at:
          http://localhost:80/\n
          Method        Route
          ==============================================
          POST          test
        """

        @test iostr == str

        # other ips
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        iostr = sprint(WebAPI.apprunning, app, ip"192.168.0.1", 80)

        str = """

          App running at:
          http://192.168.0.1:80/\n
          Method        Route
          ==============================================
          POST          test
        """

        @test iostr == str
    end
end
