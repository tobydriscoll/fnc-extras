%%
A = [1 2; -2 0]
B = [ 1 10 100; -5 5 3 ]

%%
% Applying the definition manually,
AkronB = [ A(1,1)*B, A(1,2)*B;
           A(2,1)*B, A(2,2)*B ]

%%
% But it's simpler to use the built-in @glsbegin@kron@glsend@. 
kron(A,B)
