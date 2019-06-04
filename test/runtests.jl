module TestEmbeddingsAnalysis

using Test
using LinearAlgebra
using EmbeddingsAnalysis
using Word2Vec
using ConceptnetNumberbatch

include("dump.jl")
include("conceptnet2wv.jl")
include("similarity_order.jl")
include("pca_reduction.jl")

end
