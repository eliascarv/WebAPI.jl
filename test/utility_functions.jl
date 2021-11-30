@testset "verifykeys" begin
    @testset "JSON3.Object" begin
        json = JSON3.read("""
        {
            "a": 1,
            "b": 2,
            "c": 3
        }
        """)

        @test verifykeys(json, (:a, :b, :c)) == true
        @test verifykeys(json, ["a", "b", "c"]) == true

        @test verifykeys(json, [:a, :d, :c]) == false
        @test verifykeys(json, ("a", "d", "c")) == false
    end

    @testset "WebAPI.Params" begin
        params = WebAPI.Params(:a => "1", :b => "2", :c => "3")

        @test verifykeys(params, (:a, :b, :c)) == true
        @test verifykeys(params, ["a", "b", "c"]) == true

        @test verifykeys(params, [:a, :d, :c]) == false
        @test verifykeys(params, ("a", "d", "c")) == false
    end

    @testset "WebAPI.Query" begin
        query = WebAPI.Query(:a => "1", :b => "2", :c => "3")

        @test verifykeys(query, (:a, :b, :c)) == true
        @test verifykeys(query, ["a", "b", "c"]) == true

        @test verifykeys(query, [:a, :d, :c]) == false
        @test verifykeys(query, ("a", "d", "c")) == false
    end
end