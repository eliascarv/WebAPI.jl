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

    @testset "Res (HTTP.Response)" begin
        status = 202
        headers_test = ["key" => "value"]
        body_json = Dict("x" => 10, "y" => 20)
        body_str = "Test"
        body_any = 2 + 3im
    
        @testset "One argument" begin
            res1 = Res(status)
            res2 = Res(headers_test)
            res3 = Res(body_any)
            res4 = Res(body_str)
            res5 = Res(body_json)

            @test res1.status == status
            @test res2.headers == headers_test

            @test res3.body == HTTP.bytes(string(body_any))
            @test res3.status == 200
            @test res3.headers == WebAPI.HEADERS_TEXT

            @test res4.body == HTTP.bytes(body_str)
            @test res4.status == 200
            @test res4.headers == WebAPI.HEADERS_TEXT

            @test res5.body == HTTP.bytes(JSON3.write(body_json))
            @test res5.status == 200
            @test res5.headers == WebAPI.HEADERS_JSON
        end

        @testset "Two arguments" begin
            res1 = Res(status, headers_test)
            res2 = Res(status, body_any)
            res3 = Res(status, body_str)
            res4 = Res(status, body_json)
            res5 = Res(headers_test, body_any)
            res6 = Res(headers_test, body_str)
            res7 = Res(headers_test, body_json)

            @test res1.status == status
            @test res1.headers == headers_test

            @test res2.body == HTTP.bytes(string(body_any))
            @test res2.status == status
            @test res2.headers == WebAPI.HEADERS_TEXT

            @test res3.body == HTTP.bytes(body_str)
            @test res3.status == status
            @test res3.headers == WebAPI.HEADERS_TEXT

            @test res4.body == HTTP.bytes(JSON3.write(body_json))
            @test res4.status == status
            @test res4.headers == WebAPI.HEADERS_JSON

            @test res5.body == HTTP.bytes(string(body_any))
            @test res5.status == 200
            @test res5.headers == headers_test

            @test res6.body == HTTP.bytes(body_str)
            @test res6.status == 200
            @test res6.headers == headers_test

            @test res7.body == HTTP.bytes(JSON3.write(body_json))
            @test res7.status == 200
            @test res7.headers == headers_test
        end

        @testset "Three arguments" begin
            res1 = Res(status, headers_test, body_any)
            res2 = Res(status, headers_test, body_str)
            res3 = Res(status, headers_test, body_json)

            @test res1.body == HTTP.bytes(string(body_any))
            @test res1.status == status
            @test res1.headers == headers_test

            @test res2.body == HTTP.bytes(body_str)
            @test res2.status == status
            @test res2.headers == headers_test

            @test res3.body == HTTP.bytes(JSON3.write(body_json))
            @test res3.status == status
            @test res3.headers == headers_test
        end
    end
end
    