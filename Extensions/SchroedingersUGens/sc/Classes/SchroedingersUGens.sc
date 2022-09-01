
Hip : Filter {
	*ar { arg in, freq = 400.0, mul = 1.0, add = 0.0;
		var b1 = exp(6.2831853071796.neg*freq/SampleRate.ir);
		var a0 = 0.5 + (0.5*b1);
		var a1 = a0.neg;
		var coefs = [a0, a1, b1];
		^FOS.ar(in, *coefs ++ [mul, add]);
	}
}

Lop : Filter {
	*ar { arg in, freq = 400.0, mul = 1.0, add = 0.0;
		var coeff = exp(6.2831853071796.neg*freq/SampleRate.ir);
		// var coeffInv = 1.0 - coeff;
		// ^Integrator.ar(coeffInv*in, coeff, mul, add);
		^OnePole.ar(in, coeff, mul, add);
	}
}

Hip48 : Filter {
	*ar { arg in, freq = 400.0, mul = 1.0, add = 0.0;
		var b1 = exp(0.00013089969389958.neg*freq);
		var a0 = 0.5 + (0.5*b1);
		var a1 = a0.neg;
		var coefs = [a0, a1, b1];
		^FOS.ar(in, *coefs ++ [mul, add]);
	}
}

Lop48 : Filter {
	*ar { arg in, freq = 400.0, mul = 1.0, add = 0.0;
		var coeff = exp(0.00013089969389958.neg*freq);
		^OnePole.ar(in, coeff, mul, add);
	}
}

Hip44 : Filter {
	*ar { arg in, freq = 400.0, mul = 1.0, add = 0.0;
		var b1 = exp(0.00014247585730566.neg*freq);
		var a0 = 0.5 + (0.5*b1);
		var a1 = a0.neg;
		var coefs = [a0, a1, b1];
		^FOS.ar(in, *coefs ++ [mul, add]);
	}
}

Lop44 : Filter {
	*ar { arg in, freq = 400.0, mul = 1.0, add = 0.0;
		var coeff = exp(0.00014247585730566.neg*freq);
		^OnePole.ar(in, coeff, mul, add);
	}
}

Teager : Filter {
	*ar { arg in;
		^( Delay1.ar(in).squared - (in*Delay2.ar(in)) );
	}
}

