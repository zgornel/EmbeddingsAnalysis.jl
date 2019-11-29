function translate(imodel,
                   omodel,
                   word;
                   n=10,
                   threshold=0.5,
                   vocab=omodel.vocab,
                   ofilter=identity)

	if !in(word, imodel.vocab)
        return [word]
    end
	pos, scores = cosine_vec(omodel, get_vector(imodel, word), n, vocab=vocab)
    pos = pos[scores .>= threshold]
    try
        candidates = filter(ofilter, omodel.vocab[pos])
        if isempty(candidates)
            return [word]
        else
            return candidates
        end
    catch
        return [word]
    end
end
