%%
% We will use Householder reflections to produce a QR factorization of the
% matrix
A = magic(6);
A = A(:,1:4);
[m,n] = size(A);

%%
% Our first step is to introduce zeros below the diagonal in column 1.
% Define the vector 
z = A(:,1);

%%
% Applying the Householder definitions gives us
v = z - norm(z)*eye(m,1);
P = eye(m) - 2/(v'*v)*(v*v');   % reflector

%%
% By design we can use the reflector to get the zero structure we seek:
P*z

%%
% Now we let 
A = P*A

%%
% We are set to put zeros into column 2. We must not use row 1 in any way,
% lest it destroy the zeros we just introduced. To put it another way, we
% can repeat the process we just did on the smaller submatrix
A(2:m,2:n)

%%
z = A(2:m,2);
v = z - norm(z)*eye(m-1,1);
P = eye(m-1) - 2/(v'*v)*(v*v');   % reflector

%%
% We now apply the reflector to the submatrix.
A(2:m,2:n) = P*A(2:m,2:n)

%%
% We need two more iterations of this process.
for j = 3:n
    z = A(j:m,j);
    k = m-j+1;
    v = z - norm(z)*eye(k,1);
    P = eye(k) - 2/(v'*v)*(v*v');
    A(j:m,j:n) = P*A(j:m,j:n);
end

%%
% We have now reduced the original $\bm{A}$ to an upper triangular matrix
% using four orthogonal Householder reflections:
R = A

