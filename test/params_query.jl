@testset "Crete Params" begin
    req = HTTP.Request("GET", "/params/1/2/3")
    path = "params/:a/:b/:c"
    params = WebAPI.createparams(req, path)

    @test params.a == "1"
    @test params.b == "2"
    @test params.c == "3"

    @test params.dict == Dict(:a => "1", :b => "2", :c => "3")
end

@testset "Crete Query" begin
    req = HTTP.Request("GET", "/query?a=1&b=2&c=3")
    query = WebAPI.createquery(req)

    @test query.a == "1"
    @test query.b == "2"
    @test query.c == "3"

    @test query.dict == Dict(:a => "1", :b => "2", :c => "3")
end
