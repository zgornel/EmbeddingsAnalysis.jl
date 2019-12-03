@testset "Translator" begin
    vocab1 = ["a1", "b1", "c1", "d1", "a1_b1", "b1_c1", "a1_b1_c1"]
    vectors1 = [1 2 3 4 5 6 7;
                1 1 1 1 1 2 3.0]
    vectors1./=permutedims(map(norm, (vectors1[:, i] for i in 1:size(vectors1,2))))
    wv1 = WordVectors(vocab1, vectors1)

    vocab2 = ["a2", "b2", "c2", "d2", "a2_b2", "b2_c2", "a2_b2_c2"]
    vectors2 = [1 2 3 4 5 6 7;
                1 1 1 1 1 2 3.0]
    vectors2./=permutedims(map(norm, (vectors2[:, i] for i in 1:size(vectors2,2))))
    wv2 = WordVectors(vocab2, vectors2)

    # - one token translation (n=1)
    @test translate(wv1, wv2, "a1", n=1) == (["a2"], true)
    @test translate(wv1, wv2, "a1", n=2) == (["a2", "b2"], true)
    @test translate(wv1, wv2, "x", n=1) == (["x"], false)

    # - one token translation (n=1, custom vocab)
    @test translate(wv1, wv2, "a1", n=1, vocab=["b2","c2"]) == (["b2"], true)
    @test translate(wv1, wv2, "a1", n=2, vocab=["b2", "c2"]) == (["b2", "c2"], true)
    @test translate(wv1, wv2, "x", n=1, vocab=["b2","c2"]) == (["x"], false)

    # - vector of tokens translation (complexity==1)
    @test translate(wv1, wv2, ["a1", "b1", "x"], n=1) ==
        [(["a2"], true),(["b2"], true), (["x"], false)]

    # - vector of tokens translation (complexity==2)
    @test translate(wv1, wv2, ["a1", "b1", "x"], n=1, ngram_complexity=2) ==
        [(["a2_b2"], true), (["x"], false)]
    @test translate(wv1, wv2, ["a1", "b1", "c1", "x"], n=2, ngram_complexity=2) ==
        [(["a2_b2", "d2"], true), (["c2", "b2_c2"], true), (["x"], false)]
    @test translate(wv1, wv2, ["a1", "b1", "c1", "x"], n=1, ngram_complexity=3) ==
        [(["a2_b2_c2"], true), (["x"], false)]

    # - vector of tokens (complexity=2, custom vocab)
    @test translate(wv1, wv2, ["a1", "b1", "x"], n=1, ngram_complexity=2, vocab=["a2","b2"]) ==
        [(["b2"], true), (["x"], false)]

    # - vector of tokens (complexity=2, custom vocab, filter out "_")
    @test translate(wv1,
                    wv2,
                    ["a1", "b1", "a1", "x", "b1"],
                    n=1,
                    ngram_complexity=2,
                    vocab=["a2","b2", "a2_b2"],
                    ofilter=x->!occursin("_", x)) ==
        [(["a1_b1"], false),
         (["a2"], true),
         (["x"], false),
         (["b2"], true)]
    @test translate(wv1,
                    wv2,
                    ["a1", "b1", "a1", "x", "b1"],
                    n=2,
                    ngram_complexity=2,
                    vocab=["a2","b2", "a2_b2"],
                    ofilter=x->!occursin("_", x)) ==
        [(["b2"], true),
         (["a2", "b2"], true),
         (["x"], false),
         (["b2"], true)]

end
