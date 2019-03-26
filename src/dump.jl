"""
    dump(wv::WordVectors, filename [;kind=:binary])

Writes embeddings to disk.

# Arguments
  * `wv::WordVectors` the embeddings
  * `filename::AbstractString` the embeddings file name

# Keyword arguments
  * `kind::Symbol` specifies whether the embeddings file is textual (`:text`)
or binary (`:binary`); default `:binary`
"""
function dump(fid::IO, wv::WordVectors{S,T,H}; kind::Symbol=:binary
             ) where {S<:AbstractString, T<:Real, H<:Integer}
    if kind == :binary
        _dump_binary(fid, wv)
    elseif kind == :text
        _dump_text(fid, wv)
    else
        throw(ErrorException("Supported values for the kind keyword"*
                             "argument are :text and :binary."))
    end

end

function dump(file::AbstractString, wv::WordVectors{S,T,H}; kind::Symbol=:binary
             ) where {S<:AbstractString, T<:Real, H<:Integer}
    open(file, "w") do fid
        dump(fid, wv, kind=kind)
    end
end

function _dump_binary(fid::IO, wv::WordVectors{S,T,H}
                     ) where {S<:AbstractString, T<:Real, H<:Integer}
    vector_size, vocab_size = size(wv.vectors)
    println(fid, "$vocab_size $vector_size")
    for i in 1:vocab_size
        write(fid, wv.vocab[i])
        write(fid, ' ')
        write(fid, Float32.(wv.vectors[:,i]))
        write(fid, '\n')
    end
end

function _dump_text(fid::IO, wv::WordVectors{S,T,H}
                   ) where {S<:AbstractString, T<:Real, H<:Integer}
    vector_size, vocab_size = size(wv.vectors)
    println(fid, "$vocab_size $vector_size")
    for i in 1:vocab_size
        nstr = join(map(string, wv.vectors[:,i]), " ")
        println(fid, "$(wv.vocab[i]) $(nstr)")
    end
end
