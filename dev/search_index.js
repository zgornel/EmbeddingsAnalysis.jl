var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Introduction",
    "title": "Introduction",
    "category": "page",
    "text": "CurrentModule=EmbeddingsAnalysis"
},

{
    "location": "#Introduction-1",
    "page": "Introduction",
    "title": "Introduction",
    "category": "section",
    "text": "EmbeddingsAnalysis is a package containing algorithms and utilities for embeddings processing. At this point, only word embeddings are de facto supported however other types (i.e. graph embeddings) could be used as well."
},

{
    "location": "#Processing-methods-1",
    "page": "Introduction",
    "title": "Processing methods",
    "category": "section",
    "text": "The package implements the following embeddings processing algorithms:Artetxe et al. \"Uncovering divergent linguistic information in word embeddings with lessons for intrinsic and extrinsic evaluation\", 2018\nVikas Raunak \"Simple and effective dimensionality reduction for word embeddings\", NIPS 2017 Workshopand utilities:word vector compression through CompressedWordVectors (uses QuantizedArrays.jl)\nsaving WordVectors, CompressedWordVectors objects to disk in either binary or text format\nconvert ConceptNet objects to WordVectors objects\nselection of a subset of word vectors starting from a seed vocabulary\nsimple word vector based translation (requires aligned embeddings)"
},

{
    "location": "#Installation-1",
    "page": "Introduction",
    "title": "Installation",
    "category": "section",
    "text": "Installation can be performed from either outside or inside Julia with:$ git clone https://github.com/zgornel/EmbeddingsAnalysis.jlandusing Pkg\nPkg.clone(\"https://github.com/zgornel/EmbeddingsAnalysis.jl\")respectively."
},

{
    "location": "api/#EmbeddingsAnalysis.compress-Union{Tuple{WordVectors{S,T,H}}, Tuple{H}, Tuple{T}, Tuple{S}} where H where T where S",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.compress",
    "category": "method",
    "text": "compress(wv [;kwargs...])\n\nCompresses wv::WordVectors by using array quantization.\n\nKeyword arguments\n\nsampling_ratio::AbstractFloat specifies the percentage of vectors to use\n\nfor quantization codebook creation\n\nk::Int number of quantization values for a codebook\nm::Int number of codebooks to use\nmethod::Symbol specifies the array quantization method\ndistance::PreMetric is the distance\n\nOther keyword arguments specific to the quantization methods can also be provided.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.compressedwordvectors-Union{Tuple{T}, Tuple{AbstractString,Type{T}}} where T<:Real",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.compressedwordvectors",
    "category": "method",
    "text": "compressedwordvectors(filename [,type=Float64][; kind=:text])\n\nGenerate a CompressedWordVectors type object from a file.\n\nArguments\n\nfilename::AbstractString the embeddings file name\ntype::Type type of the embedding vector elements; default Float64\n\nKeyword arguments\n\nkind::Symbol specifies whether the embeddings file is textual (:text)\n\nor binary (:binary); default :text\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.conceptnet2wv-Union{Tuple{E}, Tuple{K}, Tuple{L}, Tuple{ConceptNet{L,K,E},Language}} where E<:AbstractFloat where K<:AbstractString where L<:Languages.Language",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.conceptnet2wv",
    "category": "method",
    "text": "conceptnet2wv(cptnet, language)\n\nConverts a ConceptNet object, cptnet to a WordVectors object. The language of the word embeddings has to be specified explicitly as a Symbol or Languages.Language (Conceptnet embeddings can be multilingual).\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.cosine_vec",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.cosine_vec",
    "category": "function",
    "text": "cosine_vec(wv::WordVectors, wordvector, n=10 [;vocab=nothing])\n\nCompute the cosine similarities and return best n positions and calculated values between wordvector and the word vectors from wv. A vocabulary mask vocab can be specified to consider only a subset of word vectors.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.pca_reduction-Union{Tuple{WordVectors{S,T,H}}, Tuple{H}, Tuple{T}, Tuple{S}, Tuple{WordVectors{S,T,H},Int64}, Tuple{WordVectors{S,T,H},Int64,Int64}} where H<:Integer where T<:Real where S<:AbstractString",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.pca_reduction",
    "category": "method",
    "text": "pca_reduction(wv::WordVectors, rdim=7, outdim=size(wv.vectors,1); [do_pca=true])\n\nPost-processes word embeddings wv by removing the first rdim PCA components from the word vectors and also reduces the dimensionality to outdim through a subsequent PCA transform, if do_pca=true.\n\nArguments\n\nwv::WordVectors the word embeddings\nrdim::Int the number of PCA components to remove from the data  (default 7)\noutdim::Int the output dimensionality of the data after the PCA  dimensionality reduction; it is performed only if do_pca=true  and the default value is the same as that of the input embeddings  i.e. no reduction\n\nKeyword arguments\n\ndo_pca::Bool whether to perform a PCA transform of the  post-processed data (default true)\n\nReferences:\n\nVikas Raunak \"Simple and effective dimensionality reduction for  word embeddings\", NIPS 2017 Workshop\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.similarity_order-Union{Tuple{WordVectors{S,T,H}}, Tuple{H}, Tuple{T}, Tuple{S}, Tuple{WordVectors{S,T,H},T}} where H<:Integer where T<:Real where S<:AbstractString",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.similarity_order",
    "category": "method",
    "text": "similarity_order(wv::WordVectors, alpha=-0.65)\n\nPost-processes the word embeddings wv so that the embeddings capture more information than directly apparent through a linear transformation that adjusts the similarity order of the model. The function returns a new WordVectors object containing the processed embeddings.\n\nArguments\n\nwv::WordVectors the word embeddings\n\nalpha::AbstractFloat the α parameter of the algorithm (default -0.65)\n\nReferences:\n\nArtetxe et al. \"Uncovering divergent linguistic information in  word embeddings with lessons for intrinsic and extrinsic evaluation\",  2018\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.vocab_reduction-Tuple{WordVectors,Any,Any}",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.vocab_reduction",
    "category": "method",
    "text": "vocab_reduction(wv::WordVectors, seed, nn)\n\nProduces a reduced vocabulary version of wv by removing all but the nn nearest neighbors of each word present in the vocabulary seed.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.write2disk-Union{Tuple{H}, Tuple{S}, Tuple{T}, Tuple{D}, Tuple{U}, Tuple{Q}, Tuple{IO,CompressedWordVectors{Q,U,D,T,S,H}}} where H where S where T where D where U where Q",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.write2disk",
    "category": "method",
    "text": "write2disk(filename::AbstractString, wv::CompressedWordVectors [;kind=:binary])\n\nWrites compressed embeddings to disk.\n\nArguments\n\nfilename::AbstractString the embeddings file name\nwv::CompressedWordVectors the embeddings\n\nKeyword arguments\n\nkind::Symbol specifies whether the embeddings file is textual (:text)\n\nor binary (:binary); default :binary\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.write2disk-Union{Tuple{H}, Tuple{T}, Tuple{S}, Tuple{IO,WordVectors{S,T,H}}} where H<:Integer where T<:Real where S<:AbstractString",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.write2disk",
    "category": "method",
    "text": "write2disk(filename::AbstractString, wv::WordVectors [;kind=:binary])\n\nWrites embeddings to disk.\n\nArguments\n\nfilename::AbstractString the embeddings file name\nwv::WordVectors the embeddings\n\nKeyword arguments\n\nkind::Symbol specifies whether the embeddings file is textual (:text)\n\nor binary (:binary); default :binary\n\n\n\n\n\n"
},

{
    "location": "api/#Word2Vec.analogy_words",
    "page": "API Reference",
    "title": "Word2Vec.analogy_words",
    "category": "function",
    "text": "analogy_words(cwv, pos, neg, n=5)\n\nReturn the top n words computed by analogy similarity between positive words pos and negaive words neg. from the CompressedWordVectors cwv.\n\n\n\n\n\n"
},

{
    "location": "api/#Word2Vec.get_vector-Tuple{CompressedWordVectors,Any}",
    "page": "API Reference",
    "title": "Word2Vec.get_vector",
    "category": "method",
    "text": "get_vector(cwv, word)\n\nReturn the vector representation of word from the CompressedWordVectors cwv.\n\n\n\n\n\n"
},

{
    "location": "api/#Word2Vec.vocabulary-Tuple{CompressedWordVectors}",
    "page": "API Reference",
    "title": "Word2Vec.vocabulary",
    "category": "method",
    "text": "vocabulary(cwv)\n\nReturn the vocabulary as a vector of words of the CompressedWordVectors cwv.\n\n\n\n\n\n"
},

{
    "location": "api/#Base.size-Tuple{CompressedWordVectors}",
    "page": "API Reference",
    "title": "Base.size",
    "category": "method",
    "text": "size(cwv)\n\nReturn the word vector length and the number of words as a tuple.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.analogy-Union{Tuple{H}, Tuple{S}, Tuple{T}, Tuple{D}, Tuple{U}, Tuple{Q}, Tuple{CompressedWordVectors{Q,U,D,T,S,H},AbstractArray,AbstractArray}, Tuple{CompressedWordVectors{Q,U,D,T,S,H},AbstractArray,AbstractArray,Any}} where H where S where T where D where U where Q",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.analogy",
    "category": "method",
    "text": "analogy(cwv, pos, neg, n=5)\n\nCompute the analogy similarity between two lists of words. The positions and the similarity values of the top n similar words will be returned. For example, king - man + woman = queen will be pos=[\"king\", \"woman\"], neg=[\"man\"].\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.cosine",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.cosine",
    "category": "function",
    "text": "cosine(cwv, word, n=10)\n\nReturn the position of n (by default n = 10) neighbors of word and their cosine similarities.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.cosine_similar_words",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.cosine_similar_words",
    "category": "function",
    "text": "cosine_similar_words(cwv, word, n=10)\n\nReturn the top n (by default n = 10) most similar words to word from the CompressedWordVectors cwv.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.in_vocabulary-Tuple{CompressedWordVectors,AbstractString}",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.in_vocabulary",
    "category": "method",
    "text": "in_vocabulary(cwv, word)\n\nReturn true if word is part of the vocabulary of the CompressedWordVector cwv and false otherwise.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.index-Tuple{CompressedWordVectors,Any}",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.index",
    "category": "method",
    "text": "index(cwv, word)\n\nReturn the index of word from the CompressedWordVectors cwv.\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.similarity-Tuple{CompressedWordVectors,Any,Any}",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.similarity",
    "category": "method",
    "text": "similarity(cwv, word1, word2)\n\nReturn the cosine similarity value between two words word1 and word2.\n\n\n\n\n\n"
},

{
    "location": "api/#",
    "page": "API Reference",
    "title": "API Reference",
    "category": "page",
    "text": "Modules = [EmbeddingsAnalysis]"
},

]}
