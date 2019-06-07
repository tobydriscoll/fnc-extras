def horner(c,x):
    """
    horner(c,x)

    Evaluate a polynomial whose coefficients are given in descending order in `c`, at the point `x`, using Horner's rule.
    """

    n = len(c)
    y = c[0]
    for k in range(1,n):
        y = x*y + c[k]   

    return y