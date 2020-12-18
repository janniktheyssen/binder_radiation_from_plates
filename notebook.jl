{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "using Markdown\n",
    "using InteractiveUtils\n",
    "using Plots\n",
    "using FFTW\n",
    "using PlutoUI\n",
    "using Pkg"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "#  Part 1: Critical frequency\n",
    "Let's look at **wave-speed**, **wavelength** and **wavenumber** in more detail.\n",
    "\n",
    "The different **wave speeds** involved\n",
    "\n",
    "$c_0 = 343 \\text{ m/s}$\n",
    "\n",
    "$c_B = \\sqrt[4]{\\frac{B}{\\rho h}\\omega^2}= \\sqrt[4]{\\frac{B}{\\rho h}} \\sqrt{\\omega} = \\Lambda  \\sqrt{f}$ "
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's set up some parameters"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [],
   "source": [
    "c0 = 343\n",
    "\n",
    "B = 1000\n",
    "rho = 10\n",
    "S = 0.01\n",
    "f = 0.1:1:1000\n",
    "omega = 2 * pi * f;"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Julia 1.5.3",
   "language": "julia",
   "name": "julia-1.5"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.5.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
