module EmbeddingsAnalysis

    using LinearAlgebra
    using Languages
    using Word2Vec
    using ConceptnetNumberbatch

    import Base: dump

    export conceptnet2wv,
           similarity_order

    include("dump.jl")
    include("conceptnet2wv.jl")
    include("similarity_order.jl")
end # module
