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

    import Base: size
    import Word2Vec: analogy_words,
                     WordVectors,
                     get_vector,
                     vocabulary

    export WordVectors,
           get_vector,
           cosine_vec,
           conceptnet2wv,
           CompressedWordVectors,
           compressedwordvectors,
           compress,
           analogy_words,
           vocabulary,
           write2disk,
           similarity_order,
           pca_reduction,
           vocab_reduction,
           translate

    include("defaults.jl")          # defaults
    include("utils.jl")             # useful utilities
    include("conceptnet2wv.jl")     # convert ConceptNet to WordVectors
    include("cwv.jl")               # CompressedWordVectors
    include("write2disk.jl")        # save WordVectors to disk
    include("similarity_order.jl")  # preprocess WordVectors
    include("pca_reduction.jl")     # preprocess/reduce dimensionality of WordVectors
    include("vocab_reduction.jl")   # reduce vocabulary size of WordVectors using a seed vocabulary
    include("translator.jl")        # word-vector based translation

end # module
