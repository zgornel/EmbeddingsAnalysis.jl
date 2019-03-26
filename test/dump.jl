function fake_wordvectors(type_element::Type{T}=Float32) where T<:AbstractFloat
    vocab = ["a", "b", "c", "d", "e"]
    vectors = diagm(0 => T[1.0,2,4,5,12])
    vocab_hash = Dict(v => i for (i,v) in enumerate(vocab))
    return WordVectors(vocab, vectors, vocab_hash)
end

@testset "Dump embeddings" begin
    filepath, io = mktemp()
    for T in [Float32, Float64]
        for kind in [:text, :binary]
            # create data
            wv_orig = fake_wordvectors(T)
            # dump data
            dump(filepath, wv_orig, kind=kind)
            # reload data
            wv_loaded = wordvectors(filepath, T, kind=kind, normalize=false)
            # tests
            @test eltype(wv_orig.vectors) == eltype(wv_loaded.vectors)
            @test wv_orig.vectors == wv_loaded.vectors
            @test wv_orig.vocab == wv_loaded.vocab
            @test wv_orig.vocab_hash == wv_loaded.vocab_hash
        end
    end
end
