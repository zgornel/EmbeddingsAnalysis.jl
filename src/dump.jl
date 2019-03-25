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
function dump(file::IO,
              wv::WordVectors{S,T,H};
              kind::Symbol=:binary
             ) where {S<:AbstractString, T<:Real, H<:Integer}
    if kind == :binary
        #TODO
    elseif kind == :text
        #TODO
    else
        throw(ErrorException("Supported values for the kind keyword"*
                             "argument are :text and :binary."))
    end

end

function dump(file::AbstractString,
              wv::WordVectors{S,T,H};
              kind::Symbol=:binary
             ) where {S<:AbstractString, T<:Real, H<:Integer}
    open(file, "w") do fid
        dump(fid, wv, kind=kind)
    end
end
