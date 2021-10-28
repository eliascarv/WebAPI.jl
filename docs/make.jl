using WebAPI
using Documenter

DocMeta.setdocmeta!(WebAPI, :DocTestSetup, :(using WebAPI); recursive=true)

makedocs(;
    modules=[WebAPI],
    authors="Elias Carvalho <eliascarvdev@gmail.com> and contributors",
    repo="https://github.com/eliascarv/WebAPI.jl/blob/{commit}{path}#{line}",
    sitename="WebAPI.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://eliascarv.github.io/WebAPI.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/eliascarv/WebAPI.jl",
    devbranch="main",
)
