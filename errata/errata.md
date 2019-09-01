## Chapter 1
* **Page 19/Exercise 1.2.7.** The polynomial in part (a) should be `x^2 - (2+ep)*x + 1`, not `x^2 + (2+ep)*x + 1`. (Thanks to Nicholas Harty.)

## Chapter 4
* **Page 165 / Exercise 4.6.4.** The Sherman-Morrison formula is given incorrectly (specifically, the denominator). It should read:  
![formula](Sherman-Morrison.svg).  
(Thanks to Claudio Torres.)

## Chapter 5
* **Page 190 / (5.3.5) and (5.3.6)** The right-hand sides of both equations should be vectors, not diagonal matrices. (Thanks to Wei Cai.) 
* **Page 199 / (5.4.11)** The sum should start at k=0 to be in sync with the code (this formula is not needed elsewhere). (Thanks to Shahrokh Esmaeili.)
* **Page 201 / Exercise 5.4.5** The nodes in part (a) are given by t_j = 0.3 + jh. (Thanks to Shahrokh Esmaeili.)
* **Page 215 / Example 5.5.3** The first expression in the last line of the formula should have a negative sign in front. (Thanks to Peter Monk.) 

## Chapter 7
* **Page 305 / Theorem 7.2.2** Replace "an nonsingular" with "a nonsingular".

## Chapter 8
* **Page 362 / Function 8.5.1** The function runs correctly as printed. However, the `H` and `Q` matrices there are initially allocated smaller than their final sizes. (MATLAB expands them anyway.) Also, to be consistent with the earlier arnoldi.m function, replace `M` with `m` and `m` with `j`. 

## Chapter 9
* **Page 387 / Figure in example 9.1.1** The y-axis label was not rendered correctly; it is the cardinal polynomial l_2.
* **Page 390 / (9.6.2)** The last expression needs to be multiplied by 2. (Thanks to Wei Cai.) 
* **Page 423 / Example 9.6.2** In the last line, the results "x_1" and "x_2" should be named "t_1" and "t_2". 

## Chapter 10
* **Page 415 / Exercise 10.1.1** The boundary conditions were left out of the problem statements. Suggestions: (a) u(0) = 2, u(1) = 3; (b) u'(0) = -1, u(4) = 2; (c) u(-1) = 2, u(1) = 3.
* **Page 416 / Exercise 10.1.2** (c) Typo in boundary conditions; they should be u(-1) = -1, u(1) = 1. (d) Typo in the ODE, use (1-x^2)u'' rather than (1-u^2)u''. 
* **Page 467 / Equation (10.4.6a)** The beta in this equation should be gamma. 
* **Page 468 / Function 10.4.1** Line 15 in the function documentation should be deleted, as it references a nonexistent output argument. 

## Chapter 12 
* **Page 540 / Example 12.4.1** The z-axis of the left-side plot was omitted and should be "u". 

## Chapter 13
* **Page 547 / Example 13.1.2** The example function should read f(x,y) = sin(xy-y).
* **Page 573 / Example 13.4.2** After the reference to (13.3.6), the next sentence should start, "The second term," not "The first term." 
