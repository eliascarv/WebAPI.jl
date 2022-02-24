@testset "Prints" begin
    @testset "routetable" begin
        io = IOBuffer()
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        WebAPI.routetable(io, app)
        iostr = String(take!(io))

        str = """
          Method        Route
          ==============================================
          POST          test
        """

        @test iostr == str
    end

    @testset "App show" begin
        io = IOBuffer()
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        show(io, app)
        iostr = String(take!(io))

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
        io = IOBuffer()
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        WebAPI.apprunning(io, app, Sockets.localhost, 80)
        iostr = String(take!(io))

        str = """

          App running at:
          http://localhost:80/\n
          Method        Route
          ==============================================
          POST          test
        """

        @test iostr == str

        # other ips
        io = IOBuffer()
        app = App()
        add_post!(app, "test") do req
            body = req.body
            return body
        end

        WebAPI.apprunning(io, app, ip"192.168.0.1", 80)
        iostr = String(take!(io))

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
