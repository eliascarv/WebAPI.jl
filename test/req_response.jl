@testset "Request response" begin
    @testset "JSON Types" begin
        nt = (x = 10, y = 20)
        dict = Dict("x" => 10, "y" => 20)
        vecnt = [(x = 10, y = 20), (x = 11, y = 21)]
        vecreal = [10, 20]
        vecdict = [Dict("x" => 10, "y" => 20), Dict("x" => 11, "y" => 21)]
    
        res_nt = WebAPI._response(nt)
        res_dict = WebAPI._response(dict)
        res_vecnt = WebAPI._response(vecnt)
        res_vecreal = WebAPI._response(vecreal)
        res_vecdict = WebAPI._response(vecdict)
    
        @test res_nt.body == HTTP.bytes(JSON3.write(nt))
        @test res_dict.body == HTTP.bytes(JSON3.write(dict))
        @test res_vecnt.body == HTTP.bytes(JSON3.write(vecnt))
        @test res_vecreal.body == HTTP.bytes(JSON3.write(vecreal))
        @test res_vecdict.body == HTTP.bytes(JSON3.write(vecdict))
    end

    @testset "Strings" begin
        str = "Test"
        res_str = WebAPI._response(str)

        @test res_str.body == HTTP.bytes(str)
    end

    @testset "Anys" begin
        any_val = 2 + 3im
        res_any = WebAPI._response(any_val)

        @test res_any.body == HTTP.bytes(string(any_val))
    end

    @testset "Res" begin
        status = 202
        headers_test = ["key" => "value"]
        body_json = Dict("x" => 10, "y" => 20)

        res = WebAPI._response(Res(status, headers_test, body_json))

        @test res.body == HTTP.bytes(JSON3.write(body_json))
        @test res.status == status
        @test res.headers == headers_test
    end
end
    