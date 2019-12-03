@testset "Vocabulary reduction" begin
    d = 5
    vocab = string.('a':'z')
    vectors = rand(d, length(vocab))
    vectors./=permutedims(map(norm, (vectors[:, i] for i in 1:size(vectors,2))))
    wv = WordVectors(vocab, vectors)

    rvocab = ["a", "z"]
    rwv = vocab_reduction(wv, rvocab, 1)
    @test rwv.vocab == rvocab
    @test size(rwv) == (d, length(rvocab))

    rvocab = ["a", "z"]
    rwv = vocab_reduction(wv, rvocab, Dict(r=>1 for r in rvocab))
    @test rwv.vocab == rvocab
    @test size(rwv) == (d, length(rvocab))

    rvocab = ["a", "z"]
    rwv = vocab_reduction(wv, [rvocab..., "missing"], Dict(r=>1 for r in rvocab))
    @test rwv.vocab == rvocab
    @test size(rwv) == (d, length(rvocab))
end
