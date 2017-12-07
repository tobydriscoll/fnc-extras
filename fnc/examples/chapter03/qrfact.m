%%
% MATLAB gives direct access to both the full and thin forms of the QR
% factorization. 

A = magic(5);
A = A(:,1:4);
[m,n] = size(A)

%%
% Here is the full form:
[Q,R] = qr(A);
szQ = size(Q)
szR = size(R)

%%
% We can test that $\mathbf{Q}$ is orthogonal.
QTQ = Q'*Q
norm(QTQ - eye(m))

%%
% With a second input argument given, the thin form is returned.
[Q,R] = qr(A,0);
szQ = size(Q)
szR = size(R)

%%
% Now $\mathbf{Q}$ cannot be an orthogonal matrix, because it is not even
% square, but it is still ONC.
Q'*Q - eye(4)