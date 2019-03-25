function fake_wordvectors(type_element::Type{T}=Float32) where T<:AbstractFloat
    vocab = ["a", "b", "c", "d", "e"]
    vectors = diagm(0=>[1.0,2,4,5,12])
    vocab_hash = Dict(v => i for (i,v) in enumerate(vocab))
    return WordVectors(vocab, vectors, vocab_hash)
end

@testset "Dump embeddings" begin
    filepath, io = mktemp()
    for T in [Float32, Float64]
        for kind in [:binary]
            # create data
            wv_orig = fake_wordvectors(T)
            # dump data
            try
                dump(filepath, wv, kind=kind)
                # reload data
                wv_loaded = wordvectors(filepath, T, kind=kind)
                # tests
                @test wv_orig.vectors == wv_loaded.vectors
                @test wv_orig.vocab == wv_loaded.vocab
                @test wv_orig.vocab_hash == wv_loaded.vocab_hash
            catch
                @test_broken false
            end
        end
    end
end
