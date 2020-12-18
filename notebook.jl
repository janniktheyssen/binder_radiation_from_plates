### A Pluto.jl notebook ###

# %%
using Markdown
using InteractiveUtils

macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end


begin
	using Plots
	using FFTW
	using PlutoUI
	using Pkg
end;
# %%

println("Hello")
