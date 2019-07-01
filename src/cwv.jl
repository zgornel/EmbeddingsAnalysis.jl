struct CompressedWordVectors{Q,U,D,T,S,H}
    vocab::Vector{S}                   # vocabulary
    vectors::QuantizedMatrix{Q,U,D,T}  # quantized vectors
    vocab_hash::Dict{S,H}              # word to vector index (column)
end


# Constructors
function CompressedWordVectors(vocab::AbstractVector{S},
                               vectors::QuantizedMatrix{Q,U,D,T}) where {Q,U,D,T,S}
    length(vocab) == size(vectors, 2) ||
        throw(DimensionMismatch("Dimension of vocab and vectors are inconsistent."))
    vocab_hash = Dict{S, Int}()
    for (i, word) in enumerate(vocab)
        vocab_hash[word] = i
    end
    CompressedWordVectors(vocab, vectors, vocab_hash)
end

function Base.show(io::IO, cwv::CompressedWordVectors{Q,U,D,T,S,H}) where {Q,U,D,T,S,H}
    len_vecs, num_words = size(cwv.vectors)
    print(io, "Compressed WordVectors $(num_words) words, $(len_vecs)-element $(T) vectors")
end


"""
    compress(wv [;kwargs...])

Compresses `wv::WordVectors` by using array quantization.

# Keyword arguments
  * `sampling_ratio::AbstractFloat` specifies the percentage of vectors to use
for quantization codebook creation
  * `k::Int` number of quantization values for a codebook
  * `m::Int` number of codebooks to use
  * `method::Symbol` specifies the array quantization method
  * `distance::PreMetric` is the distance

Other keyword arguments specific to the quantization methods can also be provided.
"""
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


"""
    vocabulary(cwv)

Return the vocabulary as a vector of words of the CompressedWordVectors `cwv`.
"""
vocabulary(cwv::CompressedWordVectors) = cwv.vocab


"""
    in_vocabulary(cwv, word)

Return `true` if `word` is part of the vocabulary of the CompressedWordVector `cwv` and
`false` otherwise.
"""
in_vocabulary(cwv::CompressedWordVectors, word::AbstractString) = word in cwv.vocab


"""
    size(cwv)

Return the word vector length and the number of words as a tuple.
"""
size(cwv::CompressedWordVectors) = size(cwv.vectors)


"""
    index(cwv, word)

Return the index of `word` from the CompressedWordVectors `cwv`.
"""
index(cwv::CompressedWordVectors, word) = cwv.vocab_hash[word]


"""
    get_vector(cwv, word)

Return the vector representation of `word` from the CompressedWordVectors `cwv`.
"""
get_vector(cwv::CompressedWordVectors, word) =
      (idx = cwv.vocab_hash[word]; cwv.vectors[:,idx])


"""
    cosine(cwv, word, n=10)

Return the position of `n` (by default `n = 10`) neighbors of `word` and their
cosine similarities.
"""
function cosine(cwv::CompressedWordVectors, word, n=10)
    metrics = cwv.vectors'*get_vector(cwv, word)
    topn_positions = sortperm(metrics[:], rev = true)[1:n]
    topn_metrics = metrics[topn_positions]
    return topn_positions, topn_metrics
end


"""
    similarity(cwv, word1, word2)

Return the cosine similarity value between two words `word1` and `word2`.
"""
function similarity(cwv::CompressedWordVectors, word1, word2)
    return get_vector(cwv, word1)'*get_vector(cwv, word2)
end


"""
    cosine_similar_words(cwv, word, n=10)

Return the top `n` (by default `n = 10`) most similar words to `word`
from the CompressedWordVectors `cwv`.
"""
function cosine_similar_words(cwv::CompressedWordVectors, word, n=10)
    indx, metr = cosine(cwv, word, n)
    return vocabulary(cwv)[indx]
end
