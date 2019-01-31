These are functions from the text *Fundamentals of Numerical
Computation*, by Driscoll and Braun, 1st edition (2017).

Each chapter's functions are in a single source file as linked below.

### [Chapter 1:](functions/chapter01.jl) Numbers, problems, and algorithms

 horner (Function 1.3.1) 
:   Evaluate a polynomial using Horner's rule.

### [Chapter 2:](functions/chapter02.jl) Square linear systems

 forwardsub (Function 2.3.1) 
:   Solve a lower triangular linear system.

 backsub (Function 2.3.2) 
:   Solve an upper triangular linear system.

 lufact (Function 2.4.1) 
:   LU factorization for a square matrix.

### [Chapter 3:](functions/chapter03.jl) Overdetermined linear systems

 lsnormal (Function 3.2.1) 
:   Solve linear least squares by normal equations.

 lsqrfact (Function 3.3.1) 
:   Solve linear least squares by QR factorization.

### [Chapter 4:](functions/chapter04.jl) Roots of nonlinear equations

 newton (Function 4.3.1) 
:   Newton's method for a scalar equation.

 secant (Function 4.4.1) 
:   Secant method for a scalar equation.

 newtonsys (Function 4.5.1) 
:   Newton's method for a system of equations.

 fdjac (Function 4.6.1) 
:   Finite-difference approximation of a Jacobian.

 levenberg (Function 4.6.2) 
:   Quasi-Newton method for nonlinear systems.

### [Chapter 5:](functions/chapter05.jl) Piecewise interpolation

hatfun (Function 5.2.1)
:   Hat function/piecewise linear basis function.

plinterp (Function 5.2.2)
:   Piecewise linear interpolation.

spinterp (Function 5.3.1)
:   Cubic not-a-knot spline interpolation.

fdweights (Function 5.4.1)
:   Fornberg's algorithm for finite difference weights.

trapezoid (Function 5.6.1)
:   Trapezoid formula for numerical integration.

intadapt (Function 5.7.1)
:   Adaptive integration with error estimation.

### [Chapter 6:](functions/chapter06.jl) Initial-value problems

eulerivp (Function 6.2.1)
:   Euler's method for a scalar initial-value problem.

eulersys (Function 6.3.1)
:   Euler's method for a first-order IVP system.

ie2 (Function 6.4.1)
:   Improved Euler method for an IVP.

rk4 (Function 6.4.2)
:   Fourth-order Runge-Kutta for an IVP.

rk23 (Function 6.5.1)
:   Adaptive IVP solver based on embedded RK formulas.

ab4 (Function 6.7.1)
:   4th-order Adams-Bashforth formula for an IVP.

am2 (Function 6.7.2)
:   2nd-order Adams-Moulton (trapezoid) formula for an IVP.

### [Chapter 8:](functions/chapter08.jl) Krylov methods in linear algebra

poweriter (Function 8.2.1)
:   Power iteration for the dominant eigenvalue.

inviter (Function 8.3.1)
:   Shifted inverse iteration for the closest eigenvalue.

arnoldi (Function 8.4.1)
:   Arnoldi iteration for Krylov subspaces.

arngmres (Function 8.5.1)
:   GMRES for a linear system.

### [Chapter 9:](functions/chapter09.jl) Global function approximation

polyinterp (Function 9.2.1)
:   Polynomial interpolation by the barycentric formula.

triginterp (Function 9.5.1)
:   Trigonometric interpolation.

ccint (Function 9.6.1)
:   Clenshaw-Curtis numerical integration.

glint (Function 9.6.2)
:   Gauss-Legendre numerical integration.

intde (Function 9.7.1)
:   Doubly exponential integration over (-inf, inf).

intsing (Function 9.7.2)
:   Integrate function with endpoint singularities.

### [Chapter 10:](functions/chapter10.jl) Boundary-value problems

shoot (Function 10.1.1)
:   Shooting method for a two-point boundary-value problem.

diffmat2 (Function 10.2.1)
:   Second-order accurate differentiation matrices.

diffcheb (Function 10.2.2)
:   Chebyshev differentiation matrices.

bvplin (Function 10.3.1)
:   Solve a linear boundary-value problem.

bvp (Function 10.4.1)
:   Solve a nonlinear boundary-value problem.

fem (Function 10.5.1)
:   Piecewise linear finite elements for a linear BVP.

### [Chapter 11:](functions/chapter11.jl) Diffusion equations

diffper (Function 11.2.1)
:   Differentiation matrices for periodic end conditions.

### [Chapter 13:](functions/chapter13.jl) Two-dimensional problems

rectdisc (Function 13.2.1)
:   Discretization on a rectangle.

poissonfd (Function 13.3.1)
:   Solve Poisson's equation by finite differences.

newtonpde (Function 13.4.1)
:   Newton's method to solve an elliptic PDE.

