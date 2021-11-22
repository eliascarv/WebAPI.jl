@testset "Params" begin
    @testset "Constructor" begin
        params = WebAPI.Params(:a => "1", :b => "2", :c => "3")
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

        @test get(params, :a, "test") == "1"
        @test get(params, :b, "test") == "2"
        @test get(params, "c", "test") == "3"
        @test get(params, "d", "test") == "test"

        @test get(() -> "test", params, :a) == "1"
        @test get(() -> "test", params, :b) == "2"
        @test get(() -> "test", params, "c") == "3"
        @test get(() -> "test", params, "d") == "test"
    
        @test haskey(params, :a) == true
        @test haskey(params, "b") == true
        @test haskey(params, :d) == false

        @test propertynames(params) == [:a, :b, :c]
    end

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

        @test get(params, :a, "test") == "1"
        @test get(params, :b, "test") == "2"
        @test get(params, "c", "test") == "3"
        @test get(params, "d", "test") == "test"

        @test get(() -> "test", params, :a) == "1"
        @test get(() -> "test", params, :b) == "2"
        @test get(() -> "test", params, "c") == "3"
        @test get(() -> "test", params, "d") == "test"
    
        @test haskey(params, :a) == true
        @test haskey(params, "b") == true
        @test haskey(params, :d) == false

        @test propertynames(params) == [:a, :b, :c]
    end
end

@testset "Query" begin
    @testset "Constructor" begin
        query = WebAPI.Query(:a => "1", :b => "2", :c => "3")
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

        @test get(query, :a, "test") == "1"
        @test get(query, :b, "test") == "2"
        @test get(query, "c", "test") == "3"
        @test get(query, "d", "test") == "test"

        @test get(() -> "test", query, :a) == "1"
        @test get(() -> "test", query, :b) == "2"
        @test get(() -> "test", query, "c") == "3"
        @test get(() -> "test", query, "d") == "test"
    
        @test haskey(query, :a) == true
        @test haskey(query, "b") == true
        @test haskey(query, :d) == false

        @test propertynames(query) == [:a, :b, :c]
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

        @test get(query, :a, "test") == "1"
        @test get(query, :b, "test") == "2"
        @test get(query, "c", "test") == "3"
        @test get(query, "d", "test") == "test"

        @test get(() -> "test", query, :a) == "1"
        @test get(() -> "test", query, :b) == "2"
        @test get(() -> "test", query, "c") == "3"
        @test get(() -> "test", query, "d") == "test"
    
        @test haskey(query, :a) == true
        @test haskey(query, "b") == true
        @test haskey(query, :d) == false

        @test propertynames(query) == [:a, :b, :c]
    end
end
