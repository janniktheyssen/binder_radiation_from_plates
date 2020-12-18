### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 406e31c8-408e-11eb-3012-8fabb02d4f2e
begin
	using Plots
	using FFTW
	using PlutoUI
	using Pkg
end;

# ╔═╡ feef4e2a-4091-11eb-36da-0377c5a487ba
md"# Part 1: Critical frequency
"

# ╔═╡ 9408921a-4093-11eb-30c0-81380f89789e
md" Let's look at **wave-speed**, **wavelength** and **wavenumber** in more detail.
"

# ╔═╡ 45531b94-4091-11eb-2b28-63a362a2699d
md"The different **wave speeds** involved

$c_0 = 343 \text{ m/s}$

$c_B = \sqrt[4]{\frac{B}{\rho h}\omega^2}= \sqrt[4]{\frac{B}{\rho h}} \sqrt{\omega} = \Lambda  \sqrt{f}$ 

"

# ╔═╡ c203c9b4-4093-11eb-1543-3531e044c65c
md"Let's set up some parameters"

# ╔═╡ e5181370-408d-11eb-3ef0-1584f21cfc06
begin
	c0 = 343

	B = 1000
	rho = 10
	S = 0.01
	f = 0.1:1:1000
	omega = 2 * pi * f
end;

# ╔═╡ cc8fcff4-4093-11eb-306b-b302ec104aa9
md"... and calculate the bending wave speed for this beam:"

# ╔═╡ 05657a78-408e-11eb-11b5-8f7054c86c56
cb = (B/rho/S.*omega.^2).^0.25;

# ╔═╡ 5121aba8-4093-11eb-1ea2-65ee5722eb4c
md"### Plotting the wave speed over frequency:

"

# ╔═╡ 4e41e5f6-408e-11eb-0a0d-d9fd81a6f77a
plot(f,[ones(length(f))*c0, cb], xlabel="frequency in Hz", ylabel="phase velocity in m/s", label=("cb", "c0"))

# ╔═╡ 753faf4a-4092-11eb-1ce2-69db248fe816
md"Ok, but what about the **wavelength?**

$\lambda = \frac{c} {f}$

"

# ╔═╡ 15511da0-4090-11eb-1b26-3b4aef16fa31
begin
	lambda0 = c0 ./ f
	lambdab = cb ./ f
end;

# ╔═╡ 44cd1f3a-4094-11eb-2109-e57288a01e0a
md"### Plotting the wavelength over frequency:
"

# ╔═╡ 2b035afa-4090-11eb-22fe-5bdcc1d883ac
plot(f, [lambda0, lambdab], xlabel="frequency in Hz", ylabel="wavelength in m")

# ╔═╡ 64e421ee-4092-11eb-0afe-2f3ff012996f
md"Let's look at that in a log-log plot"

# ╔═╡ 4ede44d0-4090-11eb-27fe-a7b94fa8fa50
plot(f, [lambda0, lambdab], xlabel="frequency in Hz", ylabel="wavelength in m", scale=:log10)

# ╔═╡ 494d020e-4090-11eb-21cd-1374e6c54ed9
md"Let's look at the **wavenumber** next:

$k = \frac{2\pi}{\lambda}$

"

# ╔═╡ a8ccdd90-4094-11eb-3fc8-97628f1171bf
begin
	k0 = 2*pi./lambda0
	kb = 2*pi./lambdab
end;

# ╔═╡ ec88b92e-40ac-11eb-1580-e539db291a2b
md"### Wavenumber over frequency"

# ╔═╡ df20b4fc-4094-11eb-3692-49a339073c24
plot(f, [k0, kb], xlabel="frequency in Hz", ylabel="Wavenumber in rad/m")

# ╔═╡ 8771a7fe-410a-11eb-288d-8fc1e1b39bdf
md"# Part 2: Radiation from baffled plates"

# ╔═╡ 0eef4ade-410f-11eb-2c9b-77c2351e91ee
md"Let's first introduce a **baffle** by creating a function that is one close to the origin and zero everywhere else."

# ╔═╡ bafd6376-410d-11eb-19fe-9def86dc56da
md"set value of d: $(@bind d PlutoUI.Slider(1:100))"

# ╔═╡ 5f38e870-410e-11eb-0645-f5e8b719ec52
md"d = $d"

# ╔═╡ d776b642-410a-11eb-121c-65284c3911f0
begin
	dx = 0.5
	space_coordinate = 0:dx:100
	y = zeros(size(space_coordinate))
	y[1:d*2] .= 1
	plot(space_coordinate,y, xlabel="Distance in m", ylabel="Amplitude")
end

# ╔═╡ 4e5894b8-4110-11eb-086f-a9b6e0a668ae
md"plotting the magnitude of the Fourier Transform of this function:"

# ╔═╡ 8f9c506a-4111-11eb-0fa0-cb4421211c80
md"Now, let's introduce a **bending wave** on an infinite plate" 

# ╔═╡ b5309952-4111-11eb-1d54-8dd004dbbbd8
begin
	k_bw = 0.2
	y_bw = exp.(im*2*pi*k_bw/dx.*space_coordinate)
	plot(space_coordinate, real(y_bw), xlabel="Distance in m", ylabel="Amplitude")
end

# ╔═╡ 3bc376f4-4112-11eb-0f33-65d66049b263
md"Plotting the magnitude of the Fourier Transform of this function:"

# ╔═╡ 0c49875a-4113-11eb-26ae-0df2e156a55c
md"Now we use the baffle function to restrict the bending wave by multiplying the two:"

# ╔═╡ 20616c6c-4113-11eb-3725-f94b9e0274e5
plot(space_coordinate, y.*real(y_bw), xlabel="Distance in m", ylabel="Amplitude")

# ╔═╡ 9d175adc-4113-11eb-3a2a-1531e0b91188
md"**Multiplication in space is the same as convolution in wavenumber domain:**"

# ╔═╡ 44315dac-411b-11eb-3b04-a9dfeb20cbeb
md"# Part 3: Bringing it together

- At **one** frequency, we will have exactly **one** wavelength in air, and **one** wavelength in the infinite plate.

- A plate that is vibrating at one frequency only radiates at that frequency (Linearity)

- Radiation occurs only when the wavenumber in air is larger than the wavenumber in the structure

- For the infinite plate, there is only one wavenumber in air that has the correct wavelength at that frequency so that it can be projected on the wavelength on the structure (because there is only one wavenumber in the structure).

- For the finite plate, there is a wavenumber spectrum in the plate, containing many wavenumbers
"

# ╔═╡ 7bc18cc6-410f-11eb-291f-e5842be77a34
k = fftfreq(length(space_coordinate));

# ╔═╡ 61de788c-410f-11eb-0134-99444f180b3c
plot(fftshift(k),fftshift(abs.(fft(y)))/d/2, xlabel="Wavenumber in rad/m", ylabel="Amplitude")

# ╔═╡ 3bc6f1ee-4112-11eb-0de7-41654b3b111b
plot(fftshift(k),fftshift(abs.(fft(y_bw))), xlabel="Wavenumber in rad/m", ylabel="Amplitude")

# ╔═╡ b20d717e-4113-11eb-33c7-03647229e70f
plot(fftshift(k), fftshift(abs.(fft(y.*y_bw))), xlabel="Wavenumber in rad/m", ylabel = "Amplitude")

# ╔═╡ 7f956a06-408e-11eb-0b12-7df7ccbec9df
plotly();
# gr();
# pyplot()

# ╔═╡ Cell order:
# ╟─feef4e2a-4091-11eb-36da-0377c5a487ba
# ╟─9408921a-4093-11eb-30c0-81380f89789e
# ╟─45531b94-4091-11eb-2b28-63a362a2699d
# ╟─c203c9b4-4093-11eb-1543-3531e044c65c
# ╠═e5181370-408d-11eb-3ef0-1584f21cfc06
# ╟─cc8fcff4-4093-11eb-306b-b302ec104aa9
# ╠═05657a78-408e-11eb-11b5-8f7054c86c56
# ╟─5121aba8-4093-11eb-1ea2-65ee5722eb4c
# ╠═4e41e5f6-408e-11eb-0a0d-d9fd81a6f77a
# ╟─753faf4a-4092-11eb-1ce2-69db248fe816
# ╠═15511da0-4090-11eb-1b26-3b4aef16fa31
# ╟─44cd1f3a-4094-11eb-2109-e57288a01e0a
# ╟─2b035afa-4090-11eb-22fe-5bdcc1d883ac
# ╟─64e421ee-4092-11eb-0afe-2f3ff012996f
# ╟─4ede44d0-4090-11eb-27fe-a7b94fa8fa50
# ╟─494d020e-4090-11eb-21cd-1374e6c54ed9
# ╠═a8ccdd90-4094-11eb-3fc8-97628f1171bf
# ╟─ec88b92e-40ac-11eb-1580-e539db291a2b
# ╟─df20b4fc-4094-11eb-3692-49a339073c24
# ╟─8771a7fe-410a-11eb-288d-8fc1e1b39bdf
# ╟─0eef4ade-410f-11eb-2c9b-77c2351e91ee
# ╟─bafd6376-410d-11eb-19fe-9def86dc56da
# ╟─5f38e870-410e-11eb-0645-f5e8b719ec52
# ╟─d776b642-410a-11eb-121c-65284c3911f0
# ╟─4e5894b8-4110-11eb-086f-a9b6e0a668ae
# ╟─61de788c-410f-11eb-0134-99444f180b3c
# ╟─8f9c506a-4111-11eb-0fa0-cb4421211c80
# ╟─b5309952-4111-11eb-1d54-8dd004dbbbd8
# ╟─3bc376f4-4112-11eb-0f33-65d66049b263
# ╟─3bc6f1ee-4112-11eb-0de7-41654b3b111b
# ╟─0c49875a-4113-11eb-26ae-0df2e156a55c
# ╟─20616c6c-4113-11eb-3725-f94b9e0274e5
# ╟─9d175adc-4113-11eb-3a2a-1531e0b91188
# ╟─b20d717e-4113-11eb-33c7-03647229e70f
# ╠═44315dac-411b-11eb-3b04-a9dfeb20cbeb
# ╟─7bc18cc6-410f-11eb-291f-e5842be77a34
# ╟─406e31c8-408e-11eb-3012-8fabb02d4f2e
# ╟─7f956a06-408e-11eb-0b12-7df7ccbec9df
