@testset "Utils: cosine_vec" begin
    wv = WordVectors(["a","b","c"], [0.0 1 2; 0 1 1])
    v = [1, 1.0]
    cc = cosine_vec(wv, v)
    @test cc isa Tuple{Vector{Int}, Vector{typeof(1.0)}}
    @test cc == ([3, 2, 1], [3.0, 2, 0])

    cc = cosine_vec(wv, v; vocab=["y", "a", "b", "x"])
    @test cc isa Tuple{Vector{Int}, Vector{typeof(1.0)}}
    @test cc == ([2, 1], [2.0, 0])

    cc = cosine_vec(wv, v, 1)
    @test cc isa Tuple{Vector{Int}, Vector{typeof(1.0)}}
    @test cc == ([3], [3.0])
end
