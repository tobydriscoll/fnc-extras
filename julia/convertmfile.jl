using JSON
kernel = Dict("display_name"=>"Matlab","language"=>"matlab","name"=>"matlab")
lang = Dict("file_extension"=> ".m",
    "mimetype"=> "text/x-octave",
    "name" =>"matlab",
    "codemirror_mode"=> "octave")
#meta = Dict("kernelspec"=>kernel,"language_info"=>lang)
#meta = {"language_info":{"file_extension":".m","mimetype":"text/x-octave","help_links":[{"text":"MetaKernel Magics","url":"https://github.com/calysto/metakernel/blob/master/metakernel/magics/README.md"}],"name":"matlab","codemirror_mode":"octave","version":"0.15.1"},"kernelspec":{"name":"matlab","display_name":"Matlab","language":"matlab"}}
meta = JSON.parse("""
{
  "language_info": {
    "file_extension": ".m",
    "mimetype": "text/x-octave",
    "help_links": [
      {
        "text": "MetaKernel Magics",
        "url": "https://github.com/calysto/metakernel/blob/master/metakernel/magics/README.md"
      }
    ],
    "name": "matlab",
    "codemirror_mode": "octave",
    "version": "0.15.1"
  },
  "kernelspec": {
    "name": "matlab",
    "display_name": "Matlab",
    "language": "matlab"
  }
}
""")

indir = "/Users/driscoll/Dropbox/books/fnc-extras/fnc/examples/chapter13"
for file in filter(s->occursin(r".m$",s),readdir(indir))
    doc = read(joinpath(indir,file),String)
    cell = []
    for par in split(doc,"%%")
        isempty(par) && continue
        lines = split(par,"\n")
        text = filter(s->occursin(r"^%",s),lines)
        if length(text) > 0
            text = join(map(t->replace(t,r"^% "=>""),text)," ")
            text = replace(text,r"\|([a-z]+)\|"i=>s"`\1`")
            push!(cell,Dict("cell_type"=>"markdown","source"=>text,"metadata"=>Dict()))
        end

        code = filter(s->~isempty(s)&&!occursin(r"^%",s),lines)
        if length(code) > 0
            code = join(code,"\n")
            code = replace(code,r"xlabel\('(.*?)'\)"=>s"""xaxis=("\1")""")
            code = replace(code,r"ylabel\('(.*?)'\)"=>s"""yaxis=("\1")""")
            code = replace(code,r"zlabel\('(.*?)'\)"=>s"""zaxis=("\1")""")
            code = replace(code,r"title\('(.*?)'\)"=>s"""title="\1" """)
            code = replace(code,r"% ignore this line"=>"")
            code = replace(code,r"axis tight"=>"")
            push!(cell,Dict("cell_type"=>"code","source"=>code,"metadata"=>Dict(),"outputs"=>[],"execution_count"=>nothing))
        end
    end

    nb = Dict("cells"=>cell,"metadata"=>meta,"nbformat"=>4,"nbformat_minor"=>2)
    open(replace(file,".m"=>".ipynb"), "w") do io
        JSON.print(io,nb,3)
    end

end
