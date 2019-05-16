using Weave
set_chunk_defaults( Dict{Symbol, Any}(:eval=>false) )

for ch = filter(s->occursin(r"chapter..",s),readdir())
    for nb = filter(s->occursin(r".ipynb$",s),readdir(ch))
        weave(joinpath(ch,nb),
        out_path=joinpath("markdown",ch),
        doctype="pandoc")
    end
end
