#TODO(Corneliu): documentation
function translate(imodel,
                   omodel,
                   word::AbstractString;
                   n=10,
                   threshold=0.5,
                   vocab=nothing,
                   ofilter=x->true)
    if !in(word, imodel.vocab)
        return [word], false
    end
	pos, scores = cosine_vec(omodel, get_vector(imodel, word), n, vocab=vocab)
    pos = pos[scores .>= threshold]
    if isempty(pos)
        return [word], false
    else
        candidates = filter(ofilter, omodel.vocab[pos])
        if isempty(candidates)
            return [word], false
        else
            return candidates, true
        end
    end
end


function translate(imodel,
                   omodel,
                   words::Vector{T};
                   ngram_complexity=1,
                   separator="_",
                   kwargs...) where {T}
    if ngram_complexity == 1
        _words = words
    else
        _words = T[]
        pos = ngram_search(imodel.vocab, words; max_length=ngram_complexity)
        fpos = Iterators.flatten(pos)
        not_found_positions = setdiff(1:length(words), fpos)
        for i in eachindex(words)
            if i in not_found_positions
                # word does not exist in input languge
                push!(_words, words[i])
            else
                # Attempt to translate n-gram
                # if the word is the last part of it
                for p in pos
                    if i == maximum(p)
                        joined = join(words[p], separator, separator)
                        push!(_words, joined)
                    end
                end
            end
        end

    end
    return [translate(imodel, omodel, word; kwargs...) for word in _words]
end


function ngram_search(vocab, tokens; separator="_", max_length=3)
    # Initializations
    found = Vector{UnitRange{Int}}()
    n = length(tokens)
    i = 1
    j = n
    while i <= n
        if j-i+1 <= max_length
            token = join(tokens[i:j], separator, separator)
            is_match = token in vocab
            if is_match
                push!(found, i:j)
                i = j + 1
                j = n
                continue
            end
        end
        if i == j
            j = n
            i+= 1
        else
            j-= 1
        end
    end
    return found
end
