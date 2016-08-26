
SynthDef(\hat,{arg gate = 1, amp=1, out=0,rel=0.1;
	var env = EnvGen.ar(Env.perc(0,rel),gate,doneAction:2);
	var freq = EnvGen.ar(Env([12000,80,20000],[0.1,0.1]));
	var sig = PinkNoise.ar(env);
	sig = HPF.ar(sig,freq);
	sig = sig.tanh;
	Out.ar(out,sig*amp*12);
}).add;



SynthDef(\hat909, {|out=0, freq=230, hpf=6500, release=0.15, amp=1, fxb=0, fxv=0, bbcb=0, bbcv=0|
  var pulse, sig, env, freqs;
  freqs = [freq, freq*1.4471, freq*1.617, freq*1.9265, freq*2.5028, freq*2.6637];
  pulse = Mix.ar(Pulse.ar(freqs, {0.9.rand}!6, mul: 1));
  sig = RHPF.ar(RHPF.ar(pulse, hpf), hpf);
  env = EnvGen.kr(Env.perc(0,release),doneAction:2);
  sig = sig*env;
  Out.ar(out, Pan2.ar(sig*amp,0));
}).add;





SynthDef(\hat808, { arg out=0,tu=1, amp=0.1, gate=1, pan=0;
	var sig;
	var env = EnvGen.ar(Env.perc(0.01,0.1),doneAction:2);
	sig = Saw.ar((1..9)*1000.23*env*tu);
	sig = RHPF.ar(sig, \hpf.kr(5700), \rq.kr(0.5));
	sig = sig * (1+EnvGen.ar(Env.perc((-0.1),\rel.kr(0.1),-4),gate))*tu;
	sig = Ringz.ar(sig,(10..15)*1000.234,1).mean;
	sig = RHPF.ar(sig, \lpf.kr(2000)*env*tu, \rq.kr(0.5));
	Out.ar(out, sig*amp);
}).add;
