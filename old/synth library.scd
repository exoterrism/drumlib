SynthDef(\kickbass, { | out=2, level=1, pan=0, atk= 0.01,decay = 0.2,release=0.26, fratio=1.5,noise=1,done=2,freq1= 120,freq2=30,freq3=30,dc=1,aamp1=1,aamp2=1,aamp3=1,aamp4=1,curve1= (-4),curve2=(-2),curve3=(-4),famp1,famp2,famp3,famp4,p1,oamp=0.1,owhich2=0,ochoose=0,filter=20000|
	var env0,env1,
env1m, son, son2,son3,son4,p2;

	p2 = p1 * (-pi);
env0 = Env([aamp1,aamp2,aamp3,aamp4,0.1,0],[atk,decay,release],[curve1, curve2, curve3]);
env1 = Env([freq1,freq2,freq3],[famp1,famp2,famp3,famp4],[curve1, curve2, curve3]);

env0 = EnvGen.ar(env0,SinOsc.kr(0.025) ,doneAction:done);
	env1 = EnvGen.ar(env1);
env1m = env1.midicps;

son = LFSaw.ar(env1m,0,oamp, 1,1.4);//*LFSaw.ar(100).distort;
son2 = SinOsc.ar(env1m,0, oamp, 1,1.4);
son3 = LFPulse.ar(env1m,0, oamp, 1,1.4);
son4 = LFTri.ar(env1m,0, oamp, 1,1.4);

son = SelectX.ar(ochoose,[son,son2,son3,son4]);
	son = Pan2.ar(son,pan);
son = LeakDC.ar(son,dc,30);

//son = son ;

son = LPF.ar(son+ WhiteNoise.ar(1*noise), env1m*fratio, env0);

	son = son + SelectX.ar(owhich2,[ SinOsc.ar(env1m, [p1,p2], env0), LFSaw.ar(env1m, [p1,p2], env0);, LFPulse.ar(env1m, [p1,p2], env0), LFTri.ar(env1m, [p1,p2], env0)]);
	son = LPF.ar(son,filter+SinOsc.kr(2,0.5,200));
son = son * 1;
//son = son.clip2(1);
son = son * level.distort;
son = Pan2.ar(son, pan);
OffsetOut.ar(out, son*level).tanh;
OffsetOut.ar(32, son*level).tanh;

},

).add;


SynthDef(\kickmed, { | out = 0,level=1, pan=0, atk= 0.01,decay = 0.2,release=0.26, fratio=1.5,noise=1,done=2,freq1= 120,freq2=30,freq3=30,dc=1,aamp1=1,aamp2=1,aamp3=1,aamp4=1,curve1= (-4),curve2=(-2),curve3=(-4),famp1,famp2,famp3,famp4,p1,oamp=0.1,owhich2=0,ochoose=0|
	var env0,env1,
env1m, son, son2,son3,son4,p2;
	p2 = p1 * (-pi);
env0 = Env([aamp1,aamp2,aamp3,aamp4,0],[atk,decay,release,0.5],[curve1, curve2, curve3]);
env1 = Env([freq1,freq2,freq3],[famp1,famp2,famp3,famp4],[curve1, curve2, curve3]);

env0 = EnvGen.ar(env0, doneAction:2);
env1 = EnvGen.ar(env1);
env1m = env1.midicps;
son = LFSaw.ar(env1m,0,oamp, 1,1.4);//*LFSaw.ar(100).distort;
son2 = SinOsc.ar(env1m,0, oamp, 1,1.4);
son3 = LFPulse.ar(env1m,0, oamp, 1,1.4);
son4 = LFTri.ar(env1m,0, oamp, 1,1.4);

son = SelectX.ar(ochoose,[son,son2,son3,son4]);
son = LeakDC.ar(son,dc,30);
son = son + WhiteNoise.ar(noise);
son = LPF.ar(son, env1m*fratio, env0);
	son = son + SelectX.ar(owhich2,[ SinOsc.ar(env1m, [p1,p2], env0), LFSaw.ar(env1m, [p1,p2], env0), LFPulse.ar(env1m, [p1,p2], env0), LFTri.ar(env1m, [p1,p2], env0)]);
son = son * 1;
//son = son.clip2(1);
son = son*level.distort;
son = Pan2.ar(son, pan);
OffsetOut.ar(out, son*level).tanh;
OffsetOut.ar(10, son*level).tanh;

},
).add;



SynthDef(\snaremed, { | out = 0,level=1, pan=0, atk= 0.01,decay = 0.2,release=0.26, fratio=1.5,noise=1,done=2,freq1= 120,freq2=30,freq3=30,dc=1,aamp1=1,aamp2=1,aamp3=1,aamp4=1,curve1= (-4),curve2=(-2),curve3=(-4),famp1,famp2,famp3,famp4,p1,oamp=0.1,owhich2=0,ochoose=0|
	var env0,env1,
env1m, son, son2,son3,son4,p2;
	p2 = p1 * (-pi);
env0 = Env([aamp1,aamp2,aamp3,aamp4,0],[atk,decay,release],[curve1, curve2, curve3]);
env1 = Env([freq1,freq2,freq3],[famp1,famp2,famp3,famp4],[curve1, curve2, curve3]);

env0 = EnvGen.ar(env0, doneAction:2);
env1 = EnvGen.ar(env1);
	env1m = env1.midicps;
son = LFSaw.ar(env1m,0,oamp, 1,1.4);//*LFSaw.ar(100).distort;
son2 = SinOsc.ar(env1m,0, oamp, 1,1.4);
son3 = LFPulse.ar(env1m,0, oamp, 1,1.4);
son4 = LFTri.ar(env1m,0, oamp, 1,1.4);

son = SelectX.ar(ochoose,[son,son2,son3,son4]);
son = LeakDC.ar(son,dc,30);
son = son ;
son = LPF.ar(son, env1m, env0);
	son = son + SelectX.ar(owhich2,[ SinOsc.ar(env1m, [p1,p2], env0), LFSaw.ar(env1m, [p1,p2], env0), LFPulse.ar(env1m, [p1,p2], env0), LFTri.ar(env1m, [p1,p2], env0)]);
	son =  HPF.ar(son +BrownNoise.ar(env0/2*noise)+WhiteNoise.ar(env0*noise),fratio);
//son = son.clip2(1);

	son = Limiter.ar(son,1);
	son = son * level.distort;
son = Pan2.ar(son, pan);

OffsetOut.ar(out, son*level).tanh;
OffsetOut.ar(14, son*level).tanh;

},
).add;


SynthDef(\snarehi, {| out = 0,level=1, pan=0, atk= 0.01,decay = 0.2,release=0.26, fratio=1.5,noise=1,done=2,freq1= 120,freq2=30,freq3=30,dc=1,aamp1=1,aamp2=1,aamp3=1,aamp4=1,curve1= (-4),curve2=(-2),curve3=(-4),famp1,famp2,famp3,famp4,p1,oamp=0.1,owhich2=0,ochoose=0|
	var env0, env1,son,son1, son2,son3,son4;
	var p2  = p1 * (-pi);

env0 = Env([aamp1,aamp2,aamp3,aamp4,0],[atk,decay,release],[curve1, curve2, curve3]);
env1 = Env([freq1,freq2,freq3],[famp1,famp2,famp3,famp4],[curve1, curve2, curve3]);

	env0 = EnvGen.ar(env0,doneAction:2);
	env1 = EnvGen.ar(env1).midicps;
	//son = WhiteNoise.ar(env0*noise)+HPF.ar(BrownNoise.ar(env0*noise),1000);
	son = SelectX.ar(owhich2,[WhiteNoise.ar(env0*noise),PinkNoise.ar(env0*noise),BrownNoise.ar(env0*noise)]);
son1 = LFSaw.ar(env1,0,oamp );//*LFSaw.ar(100).distort;
son2 = SinOsc.ar(env1,0, oamp);
son3 = LFPulse.ar(env1,0, oamp);
son4 = LFTri.ar(env1,0, oamp);

//son1 = SelectX.ar(ochoose,[son1,son2,son3,son4]);
	son = son + son* SinOsc.ar(env1,[p1,p2])+SinOsc.ar(env1,[p2,p1],oamp)+SinOsc.ar(env1+20,[p1+0.5,p2],oamp);
	    // son = CombN.ar(son,0.02,fratio,2,1);

	son = Pan2.ar(son);
	//	son = LeakDC.ar(son,dc,30);
	/*son= Compander.ar(son, son,
		thresh: 0.6,
		slopeBelow: 0,
		slopeAbove: 0.4,
		clampTime: 0.1,
		relaxTime: 0.001
	);*/
	Out.ar(out,son*env0*level);
	Out.ar(14,son*env0*level);

	}
).add;


SynthDef(\clapping, {arg out = 0,t_trig=1, amp=0.5, filterfreq=120, rq=0.1;
	var env, signal, attack,  noise, hpf1, hpf2;
	noise = WhiteNoise.ar(1)+SinOsc.ar([filterfreq/2,filterfreq/2+4 ], pi*0.5, XLine.kr(1,0.01,4));
	hpf1 = RLPF.ar(noise, 400, rq);
	hpf2 = RHPF.ar(noise,  120, rq/4);
	env = EnvGen.kr(Env.perc(0.003, 0.035));
	signal = (hpf1+hpf2) * env;
	signal = CombC.ar(signal, 0.5, 0.03, 0.031)+CombC.ar(signal, 0.5, 0.03016, 0.06);
	signal = FreeVerb.ar(signal, 0.1, 0, 0.5);
	signal = Limiter.ar(signal, 0.7, 0.01) * amp;
	Out.ar(out, Pan2.ar(signal, 0));
	DetectSilence.ar(signal, doneAction:2);
}).add;




///

		SynthDef(\clap, {

			  | outputChannels=0,

			    amp = 0.5,

			    pan=0,

			    duré=1,

			    sendChannels=0,

			    send=0,

			    gate=1,

			    q=1,

			    fq=1,

			    rnd1=0,

			    rnd2=0,

			    rnd3=0

			    |



			var env1, env2, out, noise1, noise2;



			// noise 1 - 4 short repeats

			env1 = EnvGen.ar(Env.new([0, 1, 0, 1, 0, 1, 0, 1, 0],

					[0.001, 0.013+rnd1, 0, 0.01+rnd2, 0, 0.01+rnd3, 0, 0.03],

					[0, -3, 0, -3, 0, -3, 0, -4]),

					//timeScale:duré

	);

			noise1 = WhiteNoise.ar(env1);

			noise1 = HPF.ar(noise1, 1560);

			noise1 = BPF.ar(noise1, 2000*fq, 3*q);



			// noise 2 - 1 longer single

			env2 = EnvGen.ar(Env.new([0, 1, 0], [0.02, 0.1], [0, -4]),gate,

					doneAction:2,
		//timeScale:duré

	);

			noise2 = WhiteNoise.ar(env2);

			noise2 = HPF.ar(noise2, 1000);

			noise2 = BPF.ar(noise2, 1200*fq, 0.7*q, 0.7);



			out = noise1 + noise2;

			out = out * 2;

			out = out.softclip * amp;



			out=Pan2.ar(out,pan);

			OffsetOut.ar(outputChannels,out);

			OffsetOut.ar(sendChannels,[out[0]*send,out[1]*send]);





		}).add;


/////



SynthDef(\hat808, {|out=0, freq=230, hpf=6500, release=0.15, amp=1, fxb=0, fxv=0, bbcb=0, bbcv=0|
  var pulse, sig, env, freqs;
  freqs = [freq, freq*1.4471, freq*1.617, freq*1.9265, freq*2.5028, freq*2.6637];
  pulse = Mix.ar(Pulse.ar(freqs, {0.9.rand}!6, mul: 0.15));
  sig = RHPF.ar(RHPF.ar(pulse, hpf), hpf);
  env = EnvGen.kr(Env.perc(0,release),doneAction:2);
  sig = sig*env;
  Out.ar(out, Pan2.ar(sig*amp,0));
}).add;


////
