@testset "Req Body" begin
    @testset "JSON Parser" begin
        app = App()
        req_body = Dict("a" => 1, "b" => 3, "c" => -4)

        req = HTTP.Request("POST", "", [], JSON3.write(req_body))
        req_empty = HTTP.Request("POST", "", [], "")

        @test app.reqparser isa JSONParser

        @test WebAPI.parsebody(app.reqparser, req) == JSON3.read(req.body)
        @test WebAPI.parsebody(app.reqparser, req_empty) == JSON3.Object()
    end

    @testset "Text Parser" begin
        app = App(reqparser=TextParser())
        req_body = "Test String"
        req = HTTP.Request("POST", "", [], req_body)

        @test app.reqparser isa TextParser

        @test WebAPI.parsebody(app.reqparser, req) == req_body
    end
end