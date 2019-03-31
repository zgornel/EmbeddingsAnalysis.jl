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
    "text": "EmbeddingsAnalysis is a package for processing embeddings. At this point, only word embeddings are de facto supported however other types (i.e. graph embeddings) could be used as well."
},

{
    "location": "#Processing-methods-1",
    "page": "Introduction",
    "title": "Processing methods",
    "category": "section",
    "text": "The package implements the following embeddings processing algorithms:Artetxe et al. \"Uncovering divergent linguistic information in word embeddings with lessons for intrinsic and extrinsic evaluation\", 2018"
},

{
    "location": "#Installation-1",
    "page": "Introduction",
    "title": "Installation",
    "category": "section",
    "text": "Installation can be performed from either outside or inside Julia with:$ git clone https://github.com/zgornel/EmbeddingsAnalysis.jlandusing Pkg\nPkg.clone(\"https://github.com/zgornel/EmbeddingsAnalysis.jl\")respectively."
},

{
    "location": "api/#EmbeddingsAnalysis.conceptnet2wv-Union{Tuple{E}, Tuple{K}, Tuple{L}, Tuple{ConceptNet{L,K,E},Language}} where E<:AbstractFloat where K<:AbstractString where L<:Languages.Language",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.conceptnet2wv",
    "category": "method",
    "text": "conceptnet2wv(cptnet, language)\n\nConverts a ConceptNet object, cptnet to a WordVectors object. The language of the word embeddings has to be specified explicitly as a Symbol or Languages.Language (Conceptnet embeddings can be multilingual).\n\n\n\n\n\n"
},

{
    "location": "api/#EmbeddingsAnalysis.similarity_order-Union{Tuple{WordVectors{S,T,H}}, Tuple{H}, Tuple{T}, Tuple{S}, Tuple{WordVectors{S,T,H},T}} where H<:Integer where T<:Real where S<:AbstractString",
    "page": "API Reference",
    "title": "EmbeddingsAnalysis.similarity_order",
    "category": "method",
    "text": "similarity_order(wv::WordVectors, alpha=-0.65)\n\nPost-processes the word embeddings wv so that the embeddings capture more information than directly apparent through a linear transformation that adjusts the similarity order of the model. The function returns a new WordVectors object containing the processed embeddings.\n\nReferences:\n\nArtetxe et al. \"Uncovering divergent linguistic information in  word embeddings with lessons for intrinsic and extrinsic evaluation\",  2018\n\n\n\n\n\n"
},

{
    "location": "api/#Base.dump-Union{Tuple{H}, Tuple{T}, Tuple{S}, Tuple{IO,WordVectors{S,T,H}}} where H<:Integer where T<:Real where S<:AbstractString",
    "page": "API Reference",
    "title": "Base.dump",
    "category": "method",
    "text": "dump(wv::WordVectors, filename [;kind=:binary])\n\nWrites embeddings to disk.\n\nArguments\n\nwv::WordVectors the embeddings\nfilename::AbstractString the embeddings file name\n\nKeyword arguments\n\nkind::Symbol specifies whether the embeddings file is textual (:text)\n\nor binary (:binary); default :binary\n\n\n\n\n\n"
},

{
    "location": "api/#",
    "page": "API Reference",
    "title": "API Reference",
    "category": "page",
    "text": "Modules = [EmbeddingsAnalysis]"
},

]}
