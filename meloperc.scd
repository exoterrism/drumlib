

SynthDef(\cow, { arg out=0,tu=1, amp=0.5, pan=0,gate=1,rel=1;
	var sig;
	var env = EnvGen.ar(Env.adsr(0.001,0.01,0.1,rel),gate,doneAction:2);
	sig = LFPulse.ar(550*tu)+LFPulse.ar(tu*400*(env+250));
	sig = Ringz.ar(sig,(30..35)*10.234*tu,1).mean;
	//sig = Pan2.ar(sig*env, pan, amp);
	Out.ar(out, sig*amp*env);
}).add;


//STEREO



SynthDef(\notes,{arg out=0,freq = 69,gate = 1,tu = 1,amp=0.5;
	var env = EnvGen.ar(Env.perc(0.01,0.1),gate,doneAction:2);
	var sig = WhiteNoise.ar(env);
	sig = CombL.ar(sig,0.2,(freq+(432.cpsmidi-69)).midicps/SampleRate.ir,1)+sig;
	sig = CombL.ar(sig,0.2,(freq+(432.cpsmidi-69)).midicps/SampleRate.ir,0.2)+sig;
	sig = sig *env *0.5;
	sig = CompanderD.ar(sig*2,0.5,1,0.5);
	Out.ar(out,sig*amp);
}).add;


SynthDef(\notes2,{arg out=0,gate =1,notes=68,at = 0.01,sus=0.4,snd=18;
	var env = EnvGen.ar(Env.adsr(at,1,sus,1.4),gate,doneAction:2);
	//var env = EnvGen.ar(Env.perc(0.01,1),gate,doneAction:2);
	var note = (notes+(432.cpsmidi-69)).midicps;
	var sig = Mix.ar(SinOsc.ar([note,note*2,note/2]));
	sig = Splay.ar(sig*0.1);
	Out.ar(out,sig*env*0.5);
	//Out.ar(snd,sig*env);
}).add;

SynthDef(\sinus,{arg out=0, freq=100,gate =1,release=0.1,lfo=1,amp=0.5;
	var env  = EnvGen.ar(Env.perc(0,release),gate,doneAction:2);
	var sig = SinOsc.ar(freq.midicps+(432-69.midicps)*SinOsc.kr(lfo),0,env);
	sig = HPF.ar(sig,100);
	sig = CompanderD.ar(sig,0.3,0.3,1.5,0.0001,0.01);
	Out.ar(out,sig*amp);
}).add;
