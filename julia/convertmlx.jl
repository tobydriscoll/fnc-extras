for file in filter(s->occursin(".tex",s),readdir())

doc = read(file,String)

doc = replace(doc,r".*\\begin{document}\n"s=>"")
doc = replace(doc,r"\\end{document}"=>"")

doc = replace(doc,"\\begin{flushleft}"=>"")

par = split(doc,"\\begin")[3:end]
cell = fill(Dict{String,Any}(),length(par))
for (i,p) in enumerate(par)
    trunc = findfirst("\n\\end",p)[1]-1
    if occursin("matlabcode",p)
        cell[i] = Dict("cell_type"=>"code","source"=>p[14:trunc],"metadata"=>Dict(),"outputs"=>[],"execution_count"=>nothing)
    else
        cell[i] = Dict("cell_type"=>"markdown","source"=>p[7:trunc],"metadata"=>Dict())
    end
end

using JSON
kernel = Dict("display_name"=>"Matlab","language"=>"matlab","name"=>"matlab")
lang = Dict("file_extension"=> ".m",
    "mimetype"=> "text/x-octave",
    "name" =>"matlab",
    "codemirror_mode"=> "octave")
meta = Dict("kernelspec"=>kernel,"language_info"=>lang)
nb = Dict("cells"=>cell,"metadata"=>jm["metadata"],"nbformat"=>4,"nbformat_minor"=>2)
open(replace(file,".tex"=>".ipynb"), "w") do io
    JSON.print(io,nb,3)
end
