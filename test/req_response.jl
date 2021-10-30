@testset "Request Response" begin
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

    @test String(res_nt.body) == JSON3.write(nt)
    @test String(res_dict.body) == JSON3.write(dict)
    @test String(res_vecnt.body) == JSON3.write(vecnt)
    @test String(res_vecreal.body) == JSON3.write(vecreal)
    @test String(res_vecdict.body) == JSON3.write(vecdict)
end
    