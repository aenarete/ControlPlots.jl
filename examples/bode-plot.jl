using Pkg
if ! ("ControlSystemsBase" ∈ keys(Pkg.project().dependencies))
    Pkg.activate("examples")
end
using ControlSystemsBase
using ControlPlots

P = tf([1.], [1., 1])

bode_plot(P; from=-2, to=2, title="Low pass filter")