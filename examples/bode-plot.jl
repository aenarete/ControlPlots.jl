using ControlSystemsBase
using ControlPlots

P = tf([1.], [1., 1])

function frequency_response(sys; from=-1, to=2)
    w = exp10.(LinRange(from, to, 1000));
    mag, phase, w1 = bode(sys, w)
    w, mag[:], phase[:]
end

bode_plot(P)