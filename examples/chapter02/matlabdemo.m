%%
% Square brackets are used to enclose elements of a matrix
% or vector. Use spaces or commas for horizontal
% concatenation, and semicolons or new lines to indicate
% vertical concatenation.
A = [ 1, 2, 3, 4, 5; 50 40 30 20 10
    pi, sqrt(2), exp(1), (1+sqrt(5))/2, log(3) ]

%%
[m,n] = size(A)

%%
% A vector is considered to be a matrix with one singleton
% dimension.
x = [ 3; 3; 0; 1; 0 ]
size(x)

%%
% Concatenated elements within brackets may be matrices
% for a block representation, as long as all the block
% sizes are compatible.
AA = [ A; A ]
B = [ zeros(3,2), ones(3,1) ]

%%
% The dot-quote |.'| transposes a matrix. A single quote
% |'| on its own performs the hermitian (transpose and
% complex conjugation). For a real matrix, the two
% operations are the same.
A'

%%
x'

%%
% There are some convenient shorthand ways of building vectors and matrices
% other than entering all of their entries directly or in a loop. To get a
% row vector with evenly spaced entries between two endpoints, you have two
% options.
row = 1:4              % start:stop
col = ( 0:3:12 )'      % start:step:stop

%%
s = linspace(-1,1,5)'  % start,stop,number

%% 
% Accessing an element is done by giving one (for a vector) or two index
% values in parentheses. The keyword @glsbegin@end@glsend@ as an index
% refers to the last position in the corresponding dimension.
a = A(2,end-1)

%%
x(2)

%% 
% The indices can be vectors, in which case a block of the matrix is
% accessed.
A(1:2,end-2:end)    % first two rows, last three columns

%%
% If a dimension has only the index |:| (a colon), then it refers to all
% the entries in that dimension of the matrix.
A(:,1:2:end)        % all of the odd columns

%%
% The matrix and vector senses of addition, subtraction, scalar
% multiplication, multiplication, and power are all handled by the usual
% symbols. If matrix sizes are such that the operation is not defined, an
% error message will result.
B = diag( [-1 0 -5] )     % create a diagonal matrix

%%
BA = B*A     % matrix product

%%
% |A*B| causes an error. (We trap it here using a special syntax.)
try A*B, catch lasterr, end
disp('Error using  *')   % ignore this line
disp(lasterr.message)   % ignore this line

%%
% A square matrix raised to an integer power is the same as repeated matrix
% multiplication.
B^3    % same as B*B*B

%%
% In many cases, one instead wants to treat a matrix or vector as a mere
% array and simply apply a single operation to each element of it. For
% multiplication, division, and power, the corresponding operators start
% with a dot.
C = -A;

%%
% |A*C| would be an error. 

%%
elementwise = A.*C

%%
% The two operands of a dot operator have to have the
% same size---unless one is a scalar, in which case it is expanded or
% ``broadcast'' to be the same size as the other operand. 
xtotwo = x.^2

%%
twotox = 2.^x

%%
% Most of the mathematical
% functions, such as @glsbegin@cos@glsend@, @glsbegin@sin@glsend@, 
% @glsbegin@log@glsend@, @glsbegin@exp@glsend@ and @glsbegin@sqrt@glsend@,
% also operate elementwise on a matrix.
cos(pi*x') 
