"""
    horner(c,x)

Evaluate a polynomial whose coefficients are given in descending order in `c`,
at the point `x`, using Horner's rule.
"""
function horner(c,x)

    n = length(c)
    p = c[1]
    for k = 2:n
        p = x*p + c[k]
    end

    return p

end
