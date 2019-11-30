#TODO(Corneliu):
# - Define necessary methods i.e. supported signatures
# - Support ngram_complexity
# - Performance tweaks (if necessary)
function translate(imodel,
                   omodel,
                   word;
                   n=10,
                   threshold=0.5,
                   vocab=nothing,
                   ofilter=x->true)

	if !in(word, imodel.vocab)
        return [word]
    end
	pos, scores = cosine_vec(omodel, get_vector(imodel, word), n, vocab=vocab)
    pos = pos[scores .>= threshold]
    if isempty(pos)
        return [word]
    else
        candidates = filter(ofilter, omodel.vocab[pos])
        if isempty(candidates)
            return [word]
        else
            return candidates
        end
    end
end
