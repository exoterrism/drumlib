SynthDef(\clap, {
  | out=0, amp = 1, pan=0, duré=1,sendChannels=0,	send=1, gate=1, q=0.1,fq=1,rnd1=0,rnd2=0,rnd3=0|
			var env1, env2, noise1, noise2,sig;
	env1 = EnvGen.ar(\env1.kr(Env([0, 1, 0.5, 0.5, 0, 1, 0, 0.3, 0],	[0.001, 0.0013, 0, 0.01, 0, 0.001, 0, 0.03],[0, -3, 0, -3, 0, -3, 0, -4])),doneAction:2);
			noise1 = WhiteNoise.ar(env1);
			noise1 = HPF.ar(noise1, 400);
			noise1 = BPF.ar(noise1, 1000*fq, 20*q);
	env2 = EnvGen.ar(\env2.kr(Env([0, 1, 0], [0.002, 0.1], [0, -4])),gate,	doneAction:2,);
			noise2 = WhiteNoise.ar(env2);
			noise2 = HPF.ar(noise2, 2300);
			noise2 = BPF.ar(noise2, 2000*fq, 7*q, 0.7);
			sig = noise1 + noise2;
			sig = sig * 2;
			sig = sig.softclip * amp;
			OffsetOut.ar(out,sig*send);
			OffsetOut.ar(24,sig*send);
		}).add;


