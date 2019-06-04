module EmbeddingsAnalysis

    using LinearAlgebra
    using Statistics
    using Languages
    using Word2Vec
    using ConceptnetNumberbatch
    using MultivariateStats

    import Base: dump

    export conceptnet2wv,
           similarity_order,
           pca_reduction

    include("dump.jl")
    include("conceptnet2wv.jl")
    include("similarity_order.jl")
    include("pca_reduction.jl")

end # module
