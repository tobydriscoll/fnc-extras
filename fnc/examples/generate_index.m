% Auto-generates an index.html file for the example scripts, based on their
% numbering in the textbook.

filename = 'ListOfExamples.txt';
delimiter = '\t';
formatSpec = '%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
number = dataArray{:, 1};
label = dataArray{:, 2};
chaptitle = ["Numbers, problems, and algorithms"
    "Square linear systems"
    "Overdetermined linear systems"
    "Roots of nonlinear equations"
    "Piecewise interpolation"
    "Initial-value problems"
    "Matrix analysis"
    "Krylov methods in linear algebra"
    "Global function approximation"
    "Boundary-value problems"
    "Diffusion equations"
    "Advection equations"
    "Two-dimensional problems"
    ];

fid = fopen('index.html','w');
fprintf(fid,'<head><title>FNC Examples</title></head>\n');
fprintf(fid,'<body>\n');
k = 1;
for i = 1:13
    fprintf(fid,'<h3><a name="%i">Chapter %i:</a> %s</h3>\n',i,i,chaptitle(i));
    fprintf(fid,'\t<ul>\n');
    while k <= length(label)
        chap = sscanf(number(k),'%i.',1);
        if chap > i, break, end
        fprintf(fid,'\t\t<li><a href="matlab:edit(''chapter%02d/%s'')">%s</a></li>\n',i,label(k),number(k));
        k = k+1;
    end
    fprintf(fid,'\t</ul>\n');
end
fprintf(fid,'</body>\n');
fclose(fid);
