# Convert a ConceptNet object to a WordVectors object
function conceptnet2wv(cptnet::ConceptNet{L,K,E},
                       language::Languages.Language;
                      ) where {L<:Language, K<:AbstractString, E<:AbstractFloat}

    embeddings = cptnet.embeddings[language]
    vector_size = cptnet.width
    vocab_size = length(embeddings)
    vocab = Vector{String}(undef, vocab_size)
    vectors = zeros(E, vector_size, vocab_size)
    for (i, (word, wordvector)) in enumerate(embeddings)
        vocab[i] = word
        vectors[:,i] = wordvector
    end
    wv = WordVectors(vocab, vectors)
end

function conceptnet2wv(cptnet::ConceptNet{L,K,E},
                       language::Symbol=:none;
                      ) where {L<:Language, K<:AbstractString, E<:AbstractFloat}
    conceptnet2wv(cptnet, ConceptnetNumberbatch.LANGUAGES[language])
end
