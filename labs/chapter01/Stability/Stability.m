%% 1. Reference values
x = logspace(-16,0,500);
%*** Create vector y of "exact" (reference) values, using expm1.

%% 2. Direct calculation method
%*** Compute z using the direct calculation method for f.

%% 3. Relative error
%*** Compute a vector err of relative errors in z.

loglog(x,err)
xlabel('x'), ylabel('relative error')
title('Error in direct calculation')

%% 4. Find a truncation number
%*** Find n such that 0.01^n/(n+1)! is less than eps. 
%*** (Show that your value is correct.)

%% 5. Error in truncated series
%*** Apply the truncated series to each element of x.

%*** Compute vector of relative errors. 

semilogx(x,err)
xlabel('x'), ylabel('relative error')
title('Error in direct calculation')
