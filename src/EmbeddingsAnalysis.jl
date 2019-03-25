module EmbeddingsAnalysis

    using LinearAlgebra
    using Word2Vec

    import Base: dump

    export dump,
           similarity_order

    include("dump.jl")
    include("similarity_order.jl")
end # module
