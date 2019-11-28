"""
    cosine_vec(wv::WordVectors, wordvector, n=10 [;vocab=nothing])

Compute the cosine similarities and return best `n` positions and
calculated values between `wordvector` and the word vectors from `wv`.
A vocabulary mask `vocab` can be specified to consider only a subset
of word vectors.
"""
function cosine_vec(wv::WordVectors, wordvector, n=10; vocab=nothing)
    if vocab === nothing
        _vocab = wv.vocab
    else
        _vocab = intersect(vocab, wv.vocab)
    end
    idxs = [wv.vocab_hash[w] for w in _vocab]
    metrics = view(wv.vectors, :, idxs)' * wordvector
    topn_positions = sortperm(metrics, rev = true)[1:min(n, length(idxs))]
    return idxs[topn_positions], metrics[topn_positions]
end
