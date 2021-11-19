@testset "Crete Params" begin
    req = HTTP.Request("GET", "/params/1/2/3")
    path = "params/:a/:b/:c"
    params = WebAPI.createparams(req, path)
    dict = Dict(:a => "1", :b => "2", :c => "3")

    @test params.a == "1"
    @test params.b == "2"
    @test params.c == "3"

    @test params[:a] == "1"
    @test params[:b] == "2"
    @test params[:c] == "3"

    @test params["a"] == "1"
    @test params["b"] == "2"
    @test params["c"] == "3"

    @test Dict(params) == dict
    @test collect(keys(params)) == collect(keys(dict))
    @test collect(values(params)) == collect(values(dict))

    @test haskey(params, :a) == true
    @test haskey(params, "b") == true
    @test haskey(params, :d) == false
end

@testset "Crete Query" begin
    req = HTTP.Request("GET", "/query?a=1&b=2&c=3")
    query = WebAPI.createquery(req)
    dict = Dict(:a => "1", :b => "2", :c => "3")

    @test query.a == "1"
    @test query.b == "2"
    @test query.c == "3"

    @test query[:a] == "1"
    @test query[:b] == "2"
    @test query[:c] == "3"

    @test query["a"] == "1"
    @test query["b"] == "2"
    @test query["c"] == "3"

    @test Dict(query) == dict
    @test collect(keys(query)) == collect(keys(dict))
    @test collect(values(query)) == collect(values(dict))

    @test haskey(query, :a) == true
    @test haskey(query, "b") == true
    @test haskey(query, :d) == false
end
