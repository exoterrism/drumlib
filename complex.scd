//stereo

SynthDef(\noise2,{arg out = 0,rel  = 0.01,a=4;
var env0 =  EnvGen.ar(Env.new([0.1, 1, 0.3, 0], [0.01, rel], [-4, -2, -4]), doneAction:2);
var sig = CuspN.ar(
		SampleRate.ir/a,
		LFNoise2.kr([4,4],1.5,1.5),
		LFNoise2.kr([2,2],1.5,1.5),
		LFNoise2.kr([2,2],0.5,1.5),
		LFNoise2.kr([2,2],0.5,1.5);
	);
	sig = HPF.ar(sig,1000);
	sig = Limiter.ar(sig,0.4);
	sig =	[sig ,DelayL.ar(sig,0.1,100/44100)];
	//sig = PitchShift.ar(sig,0.2,1*a);
	sig = Compander.ar(sig,In.ar(0,1),0.01,1,0.01,0.01,0.1);
	sig=  sig.tanh;
	Out.ar(out,sig*env0);
}).add;



SynthDef(\noise,{arg out =0,rel  = 0.25,a=4;
var env0 =  EnvGen.ar(Env.new([0.1, 1, 0.3, 0], [0.01, rel], [-4, -2, -4]), doneAction:2);
var sig = LatoocarfianL.ar(
		SampleRate.ir/a,
		LFNoise2.kr([2,2],1.5,1.5),
		LFNoise2.kr([2,2],1.5,1.5),
		LFNoise2.kr([2,2],0.5,1.5),
		LFNoise2.kr([2,2],0.5,1.5);
	);
	sig = HPF.ar(sig,1000);
	sig = Limiter.ar(sig,0.4);
	sig =	[sig ,DelayL.ar(sig,0.1,100/44100)];
	//sig = PitchShift.ar(sig,0.2,1*a);
	sig = Compander.ar(sig,In.ar(0,1),0.01,1,0.01,0.01,0.1);
	sig=  sig.tanh;
	Out.ar(out,sig*env0);
}).add;

//

/*

Pdef(\noise,Pbind(\instrument,\noise,
	\dur,Pseq([Pseq([1/16],28),Pseq([1/4],8)],inf),
	\a,Pwhite(0.1,4,inf),
	\rel,Pseq([Pseq([1],28),Prand([0.01,0.01,0.001,1],1)],inf).coin.not,
	\isRest,Pseq([Pseq([1],28),1,0.1,0.5,1],inf).coin.not)).play;



Pdef(\noise,Pbind(\instrument,\noise,
	\dur,Pseq([Pseq([1/8],28),Pseq([1/2],8)],inf),
	\a,Pwhite(0.1,4,inf),
	\rel,Pseq([Pseq([2],28),Prand([0.01,0.01,0.001,1],1)],inf).coin.not,
\isRest,Pseq([Pseq([1],28),1,0.1,0.5,1],inf).coin.not)).play;


Pdef(\noise,Pbind(\instrument,\noise,
	\dur,1/4,
	\a,Pwhite(0.1,4,inf),
	\rel,Pseq([Pseq([0.01],28),Prand([0.01,0.01,0.001,0.001],1)],inf).coin.not,
\isRest,Pseq([Pseq([0,0,1],28),1,0.1,0.5,1],inf).coin.not)).play;




*/
