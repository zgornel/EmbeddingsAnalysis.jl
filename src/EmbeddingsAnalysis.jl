module EmbeddingsAnalysis

    using LinearAlgebra
    using Statistics
    using Languages
    using Word2Vec
    using ConceptnetNumberbatch
    using StatsBase
    using MultivariateStats
    using Distances
    using QuantizedArrays

    import Base: dump, size

    export conceptnet2wv,
           CompressedWordVectors,
           compress,
           similarity_order,
           pca_reduction

    include("defaults.jl")          # defaults
    include("dump.jl")              # save WordVectors to disk
    include("conceptnet2wv.jl")     # convert ConceptNet to WordVectors
    include("cwv.jl")               # CompressedWordVectors
    include("similarity_order.jl")  # preprocess WordVectors
    include("pca_reduction.jl")     # preprocess/reduce dimensionality of WordVectors

end # module
