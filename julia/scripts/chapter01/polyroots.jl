
using Polynomials

r = [-2.0,-1,1,1,3,6]
p = poly(r)

r_computed = sort(roots(p))

@. abs(r - r_computed) / r

p_computed = poly(r_computed)

cp = coeffs(p)
cpc = coeffs(p_computed)
@. abs(cp-cpc)/cp
