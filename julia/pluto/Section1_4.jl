### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ e99b4518-232b-40d6-85a3-7836bdbb4339
using PlutoUI

# ╔═╡ ac055b65-d859-4beb-8d6b-dd4a10d89b3c
using Polynomials

# ╔═╡ 44374561-7859-4f6b-a99c-7f9bbc9028d8
md"""
# Section 1.4
"""

# ╔═╡ 7492b07f-ad30-463e-afbb-d396425fc095
md"""
## Instability in the quadratic formula
"""

# ╔═╡ 19e1ea47-9a03-41bf-93c8-fbedb86be5a6
md"""
We apply the quadratic formula to find the roots of a quadratic via {eq}`quadunstable`.
"""

# ╔═╡ 1521e0c2-c660-4272-a7c7-f713d5049051
details(
	"Tip",
	md" A number in scientific notation is entered as `1.23e4` rather than as `1.23*10^{4}`."
)

# ╔═╡ 6ebaea8e-e7a3-45b5-a1f9-62659adc39b9
let (a, b, c) = (1, -(1e6 + 1e-6), 1)
	x₁ = (-b + sqrt(b^2 - 4a*c)) / 2a
	x₂ = (-b - sqrt(b^2 - 4a*c)) / 2a
	md"""
	x₁ = $x₁, error is $(abs(1 - x₁ / 1e6));
	x₂ = $x₂, error is $(abs(1 - x₂ / 1e-6))
	"""
end

# ╔═╡ 499fe17d-defc-497f-8878-2cbfd1fd0d25
md"""
The first root above is correct to all stored digits, but the second has fewer than six accurate digits.
"""

# ╔═╡ 4e151b42-c3bf-4d5f-bf14-68d38d3573cb
md"""
The instability is easily explained. Since $a=c=1$, we treat them as exact numbers. First, we compute the condition numbers with respect to $b$ for each elementary step in finding the "good" root:

| Calculation | Result | $\kappa$ |
|:------------|:-------|:---------|
|$u_1 = b^2$  | $1.000000000002000\times 10^{12}$ |  2 |
|$u_2 = u_1 - 4$ | $9.999999999980000\times 10^{11}$  | $\approx 1.00$ |
|$u_3 = \sqrt{u_2}$ | $999999.9999990000$ | 1/2 |
|$u_4 = u_3 - b$ | $2000000$ | $\approx 0.500$ |
|$u_5 = u_4/2$ | $1000000$  | 1 |

Using {eq}`condition-chain`, the chain rule for condition numbers, the conditioning of the entire chain is the product of the individual steps, so there is essentially no growth of relative error here. However, if we use the quadratic formula for the "bad" root, the next-to-last step becomes $u_4=(-u_3) - b$, and now  $\kappa=|u_3|/|u_4|\approx 5\times 10^{11}$. So we can expect to lose 11 digits of accuracy, which is what we observed. The key issue is the subtractive cancellation in this one step.
"""

# ╔═╡ fb24bc8b-319b-459b-a8fa-9478bf837187
md"""
## Stable alternative to the quadratic formula
"""

# ╔═╡ dbe9e71e-fd85-48b1-abed-37b89354d705
md"""
We repeat the rootfinding experiment of @demo-stability-quadbad with an alternative algorithm. Specifically we use the identity $x_1x_2=\frac{c}{a}$ to compute the smaller root $x_2$.
"""

# ╔═╡ 034add2c-7926-4a23-b775-70950e4f512d
let (a, b, c) = (1, -(1e6 + 1e-6), 1)
	x₁ = (-b + sqrt(b^2 - 4a*c)) / 2a
	x₂ = c / (a * x₁)
	md"""
	x₁ = $x₁, error is $(abs(1 - x₁ / 1e6));
	x₂ = $x₂, error is $(abs(1 - x₂ / 1e-6))
	"""
end

# ╔═╡ 2cc36567-4311-4086-8c8e-afb48eadea08
md"""
## Forward and backward error
"""

# ╔═╡ a7e797ef-20d4-4c10-9be8-b52f57d47460
md"""
For this example we will use the `Polynomials` package.  
"""

# ╔═╡ 1f00ed2a-40ab-4f62-b3ae-9818eab950b4
md"""
Our first step is to construct a polynomial with six known roots.
"""

# ╔═╡ 54ed6127-b5f0-439a-9af8-0b91ea1fdde4
r = [-2.0, -1, 1, 1, 3, 6]

# ╔═╡ 80b1b698-e8c2-4e21-8443-ace96c94f374
p = fromroots(r)

# ╔═╡ 8efae0f3-5fa8-426b-a63d-8accccb82b7d
md"""
Now we use a standard numerical method for finding those roots, pretending that we don't know them already. This corresponds to $\tilde{y}$ in {numref}`Definition {number} <definition-backward-error>`. 
"""

# ╔═╡ 505e839d-b11f-4047-85bc-a326dc180a95
r̃ = sort(roots(p))   # type r\tilde and then press Tab

# ╔═╡ 58bee3fc-5af6-45bc-b189-293f0a149648
md"""
Here are the relative errors in each of the computed roots. 
"""

# ╔═╡ d91743c7-77f8-43cf-ae7f-0834ad5db7f2
details(
	"Tip",
	md"The `@.` notation at the start means to do the given operations on each element of the given vectors."
)

# ╔═╡ 56b60157-b0fb-4a96-a205-6f59e5edb0d3
@. abs(r - r̃) / r

# ╔═╡ 9299c965-8eb5-4e7d-99be-fccac07ea144
md"""
It seems that the forward error is acceptably close to machine epsilon for double precision in all cases except the double root at $x=1$. This is not a surprise, though, given the poor conditioning at such roots.

Let's consider the backward error. The data in the rootfinding problem is the polynomial coefficients. We can apply `fromroots` to find the coefficients of the polynomial (that is, the data) whose roots were actually computed by the numerical algorithm. This corresponds to $\tilde{x}$ in {numref}`Definition {number} <definition-backward-error>`. 
"""

# ╔═╡ e40709fa-efb2-4f86-916d-feff9e005dcb
p̃ = fromroots(r̃)

# ╔═╡ 1412efcd-4051-416d-b024-ce71862e5bc3
md"""
We find that in a relative sense, these coefficients are very close to those of the original, exact polynomial:
"""

# ╔═╡ 07dbd207-51dd-4adc-bf31-21ed5f548461
c, c̃ = coeffs(p), coeffs(p̃);

# ╔═╡ 9acdae1a-e5eb-4a67-8ac1-202a28dd26cf
@. abs(c - c̃) / c

# ╔═╡ ac727969-6fbc-4fa2-9d15-64e3291609fb
md"""
In summary, even though there are some computed roots relatively far from their correct values, they are nevertheless the roots of a polynomial that is very close to the original.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Polynomials = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"

[compat]
PlutoUI = "~0.7.68"
Polynomials = "~4.1.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.0-rc1"
manifest_format = "2.0"
project_hash = "5f494c0d226a23009e7345a3761b32fb0487dbc2"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.11.1+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.13.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ec9e63bd098c50e4ad28e7cb95ca7a4860603298"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.68"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "972089912ba299fba87671b025cd0da74f5f54f7"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.1.0"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieExt = "Makie"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "516f18f048a195409d6e072acf879a9f017d3900"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.12.0"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.8.3+2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.13.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.5.0+2"
"""

# ╔═╡ Cell order:
# ╠═e99b4518-232b-40d6-85a3-7836bdbb4339
# ╟─44374561-7859-4f6b-a99c-7f9bbc9028d8
# ╟─7492b07f-ad30-463e-afbb-d396425fc095
# ╟─19e1ea47-9a03-41bf-93c8-fbedb86be5a6
# ╠═1521e0c2-c660-4272-a7c7-f713d5049051
# ╠═6ebaea8e-e7a3-45b5-a1f9-62659adc39b9
# ╟─499fe17d-defc-497f-8878-2cbfd1fd0d25
# ╟─4e151b42-c3bf-4d5f-bf14-68d38d3573cb
# ╟─fb24bc8b-319b-459b-a8fa-9478bf837187
# ╟─dbe9e71e-fd85-48b1-abed-37b89354d705
# ╠═034add2c-7926-4a23-b775-70950e4f512d
# ╟─2cc36567-4311-4086-8c8e-afb48eadea08
# ╟─a7e797ef-20d4-4c10-9be8-b52f57d47460
# ╠═ac055b65-d859-4beb-8d6b-dd4a10d89b3c
# ╟─1f00ed2a-40ab-4f62-b3ae-9818eab950b4
# ╠═54ed6127-b5f0-439a-9af8-0b91ea1fdde4
# ╠═80b1b698-e8c2-4e21-8443-ace96c94f374
# ╟─8efae0f3-5fa8-426b-a63d-8accccb82b7d
# ╠═505e839d-b11f-4047-85bc-a326dc180a95
# ╟─58bee3fc-5af6-45bc-b189-293f0a149648
# ╟─d91743c7-77f8-43cf-ae7f-0834ad5db7f2
# ╠═56b60157-b0fb-4a96-a205-6f59e5edb0d3
# ╟─9299c965-8eb5-4e7d-99be-fccac07ea144
# ╠═e40709fa-efb2-4f86-916d-feff9e005dcb
# ╟─1412efcd-4051-416d-b024-ce71862e5bc3
# ╠═07dbd207-51dd-4adc-bf31-21ed5f548461
# ╠═9acdae1a-e5eb-4a67-8ac1-202a28dd26cf
# ╟─ac727969-6fbc-4fa2-9d15-64e3291609fb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
