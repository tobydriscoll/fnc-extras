
using Images, TestImages
img = testimage("peppers")

@show size(img),eltype(img)

R = red.(img)
R[1:5,1:5]

G = Gray.(img)

A = @. gray(Gray(img))
A[1:5,1:5]

save("peppers.png",Gray.(img))

load("peppers.png")
