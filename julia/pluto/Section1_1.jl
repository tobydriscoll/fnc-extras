### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ 662620d1-64a9-4dfd-a205-9dc8ddd4c5c6
md"# Section 1.1"

# ╔═╡ 26a0251a-2f19-4adb-8a70-69ae833cc0f8
md"## [Absolute and relative accuracy](https://fncbook.com/floating-point#demo-float-accuracy)"

# ╔═╡ ca36e69e-c22f-4178-9e6b-72db73ee5cac
p = 22/7

# ╔═╡ 69a170ef-67f6-4aa6-a1ec-d4682b300d83
float(π)

# ╔═╡ b59fbb96-40e4-4793-811d-420994c1cc4f
absolute_accuracy = abs(p - π)

# ╔═╡ b9b939ae-1ef0-4ce4-af68-08c090f5530b
relative_accuracy = absolute_accuracy / π

# ╔═╡ 42f999a3-60d5-413e-a536-f16546e36cc7
md"Number of accurate digits = $(-log10(relative_accuracy))"

# ╔═╡ 15120f01-cbc4-4dc4-9a30-eb5d06db3b73
md"## [Floating-point representation](https://fncbook.com/floating-point#demo-float-double)"

# ╔═╡ f3dc08c7-86d4-4c41-8300-108b36481985
typeof(1), typeof(1.0)

# ╔═╡ 3196b7cb-9534-4d70-b5df-75839e967e14
bitstring(1.0)

# ╔═╡ 065a4390-1930-4107-a2a3-4b7a779abbdb
bitstring(-1.0)

# ╔═╡ e81267d2-e45a-4864-ae46-d1360ced8d8d
[bitstring(1.0), bitstring(2.0)]

# ╔═╡ 1e4e2702-7051-4133-b698-e5c6e751d21f
let x = 3.14
	sign(x), exponent(x), significand(x)
end

# ╔═╡ 739d2125-32d7-4aad-a2a7-41a05a5e0311
eps()

# ╔═╡ 7040090e-d9b2-4dc5-82d3-588b13938a9d
log2(eps())

# ╔═╡ 59296582-676c-432a-8754-251df12234b1
eps(1.618)

# ╔═╡ 81cc9bbd-701f-4c6a-9f69-a825e9609e35
eps(161.8)

# ╔═╡ b1c34950-5414-4185-9e8f-874718e2a8ef
nextfloat(161.8) - 161.8

# ╔═╡ 6ab4d102-165a-4ef7-ab2c-7a00dca3730a
floatmin(), floatmax()

# ╔═╡ 206abbed-fb61-4e47-be07-28ad9e71906f
1 / 7

# ╔═╡ e1daf0ef-583d-447c-84dc-063781ecbfaa
37.3 + 1

# ╔═╡ aafde7a6-0c4a-457b-99ba-8e05fb5754f9
2^(-4)

# ╔═╡ a7cb880d-6a24-4290-b8c9-e49a721a6857
Int(5.0)

# ╔═╡ 2577f356-2527-4e9b-a460-a2e93ac5ba64
Int(5.1)

# ╔═╡ f66f4040-6bc5-4145-9045-f3a922d2b1a0
md"## [An oddity in floating-point arithmetic](https://fncbook.com/floating-point/#demo-float-arithmetic)"

# ╔═╡ ef2c642a-84ac-49ac-b5a8-0aea2ad7e17d
let e = eps()/2
	(1.0 + e) - 1.0
end

# ╔═╡ 58e320b2-ae5f-4026-b40a-94002d4bb8f4
let e = eps()/2
	1.0 + (e - 1.0)
end

# ╔═╡ Cell order:
# ╟─662620d1-64a9-4dfd-a205-9dc8ddd4c5c6
# ╟─26a0251a-2f19-4adb-8a70-69ae833cc0f8
# ╠═ca36e69e-c22f-4178-9e6b-72db73ee5cac
# ╠═69a170ef-67f6-4aa6-a1ec-d4682b300d83
# ╠═b59fbb96-40e4-4793-811d-420994c1cc4f
# ╠═b9b939ae-1ef0-4ce4-af68-08c090f5530b
# ╠═42f999a3-60d5-413e-a536-f16546e36cc7
# ╟─15120f01-cbc4-4dc4-9a30-eb5d06db3b73
# ╠═f3dc08c7-86d4-4c41-8300-108b36481985
# ╠═3196b7cb-9534-4d70-b5df-75839e967e14
# ╠═065a4390-1930-4107-a2a3-4b7a779abbdb
# ╠═e81267d2-e45a-4864-ae46-d1360ced8d8d
# ╠═1e4e2702-7051-4133-b698-e5c6e751d21f
# ╠═739d2125-32d7-4aad-a2a7-41a05a5e0311
# ╠═7040090e-d9b2-4dc5-82d3-588b13938a9d
# ╠═59296582-676c-432a-8754-251df12234b1
# ╠═81cc9bbd-701f-4c6a-9f69-a825e9609e35
# ╠═b1c34950-5414-4185-9e8f-874718e2a8ef
# ╠═6ab4d102-165a-4ef7-ab2c-7a00dca3730a
# ╠═206abbed-fb61-4e47-be07-28ad9e71906f
# ╠═e1daf0ef-583d-447c-84dc-063781ecbfaa
# ╠═aafde7a6-0c4a-457b-99ba-8e05fb5754f9
# ╠═a7cb880d-6a24-4290-b8c9-e49a721a6857
# ╠═2577f356-2527-4e9b-a460-a2e93ac5ba64
# ╟─f66f4040-6bc5-4145-9045-f3a922d2b1a0
# ╠═ef2c642a-84ac-49ac-b5a8-0aea2ad7e17d
# ╠═58e320b2-ae5f-4026-b40a-94002d4bb8f4
