"""
    vocab_reduction(wv::WordVectors, seed, nn)

Produces a reduced vocabulary version of `wv` by removing all but
the `nn` nearest neighbors of each word present in the
vocabulary `seed`.
"""
function vocab_reduction(wv::WordVectors, seed, nn)
    idxs = Int[]
    for word in unique(seed)
        if word in wv.vocab
            n = _get_neighbors_number(word, nn)
            pos, _ = cosine_vec(wv, Word2Vec.get_vector(wv, word), n)
            push!(idxs, pos...)
        end
    end
    unique!(idxs)
    return WordVectors(wv.vocab[idxs], wv.vectors[:, idxs])
end


_get_neighbors_number(word, nn::Int) = nn  # fixed number of neighbors
_get_neighbors_number(word::T, nn::Dict{T, Int}) where {T} = nn[word]  # different neighbor number for each vocab entry
