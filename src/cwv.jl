struct CompressedWordVectors{U,D,T,S,H}
    vocab::Vector{S}                # vocabulary
    vectors::QuantizedMatrix{U,D,T} # quantized vectors
    vocab_hash::Dict{S, H}          # word to vector index (column)
end

# Constructors
function CompressedWordVectors(vocab::AbstractVector{S},
                               vectors::QuantizedMatrix{U,D,T}) where {U,D,T,S}
    length(vocab) == size(vectors, 2) ||
        throw(DimensionMismatch("Dimension of vocab and vectors are inconsistent."))
    vocab_hash = Dict{S, Int}()
    for (i, word) in enumerate(vocab)
        vocab_hash[word] = i
    end
    CompressedWordVectors(vocab, vectors, vocab_hash)
end

function Base.show(io::IO, wv::CompressedWordVectors{U,D,T,S,H}) where {U,D,T,S,H}
    len_vecs, num_words = size(wv.vectors)
    print(io, "Compressed WordVectors $(num_words) words, $(len_vecs)-element $(T) vectors")
end


function compress(wv::WordVectors{S,T,H};
                  sampling_ratio::AbstractFloat=DEFAULT_QUANTIZATION_SAMPLING_RATIO,
                  k::Int=DEFAULT_QUANTIZAION_K,
                  m::Int=DEFAULT_QUANTIZATION_M,
                  method::Symbol=DEFAULT_QUANTIZATION_METHOD,
                  distance::Distances.PreMetric=DEFAULT_QUANTIZATION_DISTANCE,
                  kwargs...) where {S,T,H}
    # Checks, initializations#
    @assert 0.0 < sampling_ratio <= 1.0 "The sampling ratio must be in >0 and <=1"
    m, n = size(wv)
    ns = clamp(round(Int, sampling_ratio * n), 1, n)

    # Sample vectors, build quantizer, quantize everything and return
    @debug "Building quantizer using $ns vectors..."
    svecs = wv.vectors[:, sample(1:n, ns, replace=false)]
    aq = build_quantizer(svecs, k=k, m=m, method=method, distance=distance; kwargs...)
    @debug "Quantizing $n vectors..."
    qvecs = quantize(aq, wv.vectors)
    return CompressedWordVectors(wv.vocab, qvecs)
end

