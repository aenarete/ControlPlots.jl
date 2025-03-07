module ControlPlotsExt

using ControlSystemsBase
using ControlPlots, Printf, LaTeXStrings

import ControlPlots: bode_plot

"""
    frequency_response(sys; from=-6, to=1)

Calculate the response of a linear system in the frequency domain.

Parameters:
- sys:  linear system
- from: exp10 of the start frequency, default -6 which means f_start = 10e-6 rad/s
- to:   exp10 of the stop frequency,  default 1 which means f_stop = 10 rad/s

Returns:
A tuple of the three vectors w, mag, phase
- w:     vector of frequencies in rad/s
- mag:   magnitude (gain), to convert into dB use `todb.(mag)`
- phase: phase in degrees
"""
function frequency_response(sys; from=-1, to=2)
    w = exp10.(LinRange(from, to, 1000));
    mag, phase, w1 = bode(sys, w)
    w, mag[:], phase[:]
end

todb(mag) = 20 * log10(mag)

"""
    bode_plot(sys::Union{StateSpace, TransferFunction}; title="", from=-3, to=1, fig=true, db=true, hz=true,
                                     db=true, hz=true, bw=false, linestyle="solid", show_title=true, fontsize=18)

Create a bode plot of a linear system. Parameters:
- title      (String)
- from       (min frequency in rad/s, default -3, means 1e-3)
- to         (max frequency in rad/s, default  1, means 1e1)
- fig        (default true, create a new figure)
- db         (default true, use decibel as unit for the magnitude)
- hz         (default true, use Hz as unit for the frequency)
- bw         (default false, if true, the bode plot is in black and white)
- linestyle  (default "solid", line style for the bode plot)
- show_title (default true, show title)
- fontsize   (default 18, font size for the labels)

Returns: nothing
"""
function bode_plot(sys::Union{StateSpace, TransferFunction}; title="", from=-1, to=1, fig=true, 
                   db=true, hz=true, bw=false, linestyle="solid", show_title=true, fontsize=18)
    lbl=""
    if fig; plt.figure(title, figsize=(8, 6)); end
    ax1 = plt.subplot(211) 
    w, mag, phase = frequency_response(sys; from, to)
    if hz
        w = w / (2 * π)
    end
    if db
        if bw
            ax1.plot(w, todb.(mag), label=lbl, color="black", linestyle=linestyle)
        else
            ax1.plot(w, todb.(mag), label=lbl)
        end
        ax1.set_xscale("log")
        plt.setp(ax1.get_xticklabels(), visible=false)
        plt.ylabel("Magnitude [dB]", fontsize = fontsize)
    else
        plt.loglog(w, mag, label=lbl)
        plt.ylabel("Magnitude", fontsize = fontsize)
    end
    plt.xlim(w[begin], w[end])
    if hz
        plt.xlabel("Frequency [Hz]", fontsize = fontsize)
    else    
        plt.xlabel("Frequency [rad/s]", fontsize = fontsize)
    end
    plt.grid(true, which="both", ls="-.")
    if show_title
        plt.title(title, fontsize = fontsize)
    end
    ax2 = plt.subplot(212, sharex=ax1) 
    if bw
        ax2.plot(w, phase, color="black", linestyle=linestyle)
    else
        ax2.plot(w, phase)
    end

    ax2.set_xscale("log")
    ax2.grid(true, which="both", ls="-.")
    plt.ylabel("Phase [deg]", fontsize = fontsize)
    if hz
        plt.xlabel("Frequency [Hz]", fontsize = fontsize)
    else    
        plt.xlabel("Frequency [rad/s]", fontsize = fontsize)
    end 
    plt.subplots_adjust(hspace=0.05, bottom=0.11, right=0.97, left=0.11)
    if title == ""
        plt.subplots_adjust(top=0.97)
    else
        plt.subplots_adjust(top=0.94)
    end
    plt.pause(0.01)
    plt.show(block=false)
    nothing
end

end