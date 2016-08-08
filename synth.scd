//kick

s.meter;
(
SynthDef("kick", {
	arg outBus=0,tu = 1,amp=1;
	var env0, env1, env1m, out;
	env0 =  EnvGen.ar(Env.new([0.5, 1, 0.3, 0], [0.01, 0.5, 0.26], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.ar(Env.new([120, 43, 29], [0.01, 0.29], [-4, -5]));
	env1m = env1.midicps;
	out = LFPulse.ar(env1m*tu, 0, 0.5, 1, -0.5);
	out = out + WhiteNoise.ar(1);
	out = LPF.ar(out, env1m*1.5, env0);
	out = out + SinOsc.ar(env1m*tu, 0.5, env0*4);
	out = out * amp;
	out = out.clip2(1);
	Out.ar(outBus, out.dup);
}).send(s);

SynthDef("kickhi", {
	arg outBus=0,tu = 1;
	var env0, env1, env1m, out;
	env0 =  EnvGen.ar(Env.new([0.5, 0.1, 0.01, 0.01,0], [0.01, 0.5, 0.26,0.1], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.ar(Env.new([122, 30, 29,120], [0.005, 0.29,0.001], [-4, -5]));
	env1m = env1.midicps;
	out = LFPulse.ar(env1m*tu, 0, 0.5, 1, -0.5);
	out = out + WhiteNoise.ar(1);
	out = LPF.ar(out, env1m*1.5, env0);
	out = out + SinOsc.ar(env1m*tu, 0.5, env0*4);
	out = out * 1.2;
	out = out.clip2(1);
	Out.ar(3, out);
}).send(s);

SynthDef(\kick2,{arg gate = 1, tu = 1,amp=0.1,atf = 80, rel =3,out=0,frequ=60;
	var env = EnvGen.ar(Env.perc(0,rel),gate,doneAction:2);
	var freq = EnvGen.ar(Env([atf,frequ,30],[0.02,rel]));
	var sig = SinOsc.ar(freq*tu,0,env);
	Out.ar([0,1],sig * amp);
}).add;


SynthDef(\kick3,{arg gate = 1, tu = 1,amp=0.1, rel =3,out=0,frequ=60;
	var env = EnvGen.ar(Env.perc(0,rel),gate,doneAction:2);
	var freq = EnvGen.ar(Env([130,frequ,30],[0.05,rel]));
	var sig = SinOsc.ar(freq*tu,0,env);
	Out.ar([0,1],sig * amp);
}).add;


SynthDef(\kicknoise,{arg amp=0.5;
	var env = EnvGen.ar(Env([0,1,0],[0.01,1]),doneAction:2);
	var freq =EnvGen.ar(Env([20000,100,30],[0.005,1]));
	var sig =  SinOsc.ar(freq,0,env)+(WhiteNoise.ar(1)*env);
	Out.ar([0,1],sig*amp);
}).add;

SynthDef(\t1kick,{arg rel = 0.6,pitch=0.1 ,fader =1 ,snd;
	var enva = EnvGen.ar(Env([0.01,1,0],[0.001,rel]),doneAction:2);
	var envf = EnvGen.ar(Env([1008,0],[0.01,1]));
	var sig = SinOsc.ar(envf+50,0,enva);
	sig = HPF.ar(sig*enva,90);
	Out.ar([2,3],sig*fader);
}).add;

SynthDef(\t1kick2,{arg out = 0,rel = 0.6,pitch=0.1 ,amp =1 ,snd;
	var enva = EnvGen.ar(Env([1,1,0],[rel,0.2]),doneAction:2);
	var envf = EnvGen.ar(Env([10000,20,00,4],[0.002,0.1,1,1]));
	var sig = SinOsc.ar(envf+50*pitch,0,enva);
	//sig = PitchShift.ar(sig,0.001,pitch,0.1);
	sig = sig.distort;
	sig = HPF.ar(FreeVerb.ar(sig,1,1),100)+sig;
	Out.ar([0,1],sig*amp*enva);
	Out.ar([14,15],sig*amp*enva);

	//Out.ar(snd,sig);
}).add;

SynthDef(\kickmed, { | out = 0,level=1, pan=0, atk= 0.01,decay = 0.2,release=0.26, fratio=1.5,noise=1,done=2,freq1= 120,freq2=30,freq3=30,dc=1,aamp1=1,aamp2=1,aamp3=1,aamp4=1,curve1= (-4),curve2=(-2),curve3=(-4),famp1,famp2,famp3,famp4,p1,oamp=0.1,owhich2=0,ochoose=0|
	var env0,env1,
env1m, son, son2,son3,son4,p2;
	p2 = p1 * (-pi);
env0 = Env([aamp1,aamp2,aamp3,aamp4,0],[atk,decay,release,0.5],[curve1, curve2, curve3]);
env1 = Env([freq1,freq2,freq3],[famp1,famp2,famp3,famp4],[curve1, curve2, curve3]);
env0 = EnvGen.ar(env0, doneAction:2);
env1 = EnvGen.ar(env1);
env1m = env1.midicps;
	son = LFSaw.ar(env1m,[0,1],oamp, 1,1.4);
	son2 = SinOsc.ar(env1m, [1,0], oamp, 1,1.4);
	son3 = LFPulse.ar(env1m,[0,1], oamp, 1,1.4);
	son4 = LFTri.ar(env1m,[1,0], oamp, 1,1.4);

son = SelectX.ar(ochoose,[son,son2,son3,son4]);
son = LeakDC.ar(son,dc,30);
son = son + WhiteNoise.ar(noise);
son = LPF.ar(son, env1m*fratio, env0);
	son = son + SelectX.ar(owhich2,[ SinOsc.ar(env1m, [p1,p2], env0), LFSaw.ar(env1m, [p1,p2], env0), LFPulse.ar(env1m, [p1,p2], env0), LFTri.ar(env1m, [p1,p2], env0)]);
son = son * 1;
son = son*level.distort;
OffsetOut.ar(0, son*level).tanh;
OffsetOut.ar(18, Mono(son)*level).tanh;

},
).add;

//snare

SynthDef(\snare, { arg out=0,tu=1, amp=0.1, gate=1, pan=0, freq=200;
	var sig;
	var env = EnvGen.ar(Env.perc(0.01,0.1));
	var enf = EnvGen.ar(Env([600,1057,230],[0.01,0.01],-4));
	sig = SinOsc.ar(tu*enf+127,0,0.5)*env;
	sig = WhiteNoise.ar+sig;
	sig = RHPF.ar(sig, \hpf.kr(170)*tu, \rq.kr(0.5));
	sig = sig + Mix.ar(BPF.ar(sig,[327,430],[0.5,0.5])*0.1);
	sig = RLPF.ar(sig, \lpf.kr(15100)*tu, \rq.kr(0.5));
	sig = sig * EnvGen.ar(Env.perc(0.01,\rel.kr(0.1),-4),gate,doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(2, sig);
}).add;

SynthDef(\snare2,{arg gate = 1, amp=1, out=0;
	var env = EnvGen.ar(Env.perc(0.001,0.5),gate,doneAction:2);
	var freq = EnvGen.ar(Env([12000,80,20000],[0.01,5]));
	var sig = WhiteNoise.ar(env);
	sig = HPF.ar(sig,freq);
	sig = sig.tanh;
//	sig = FreeVerb.ar(sig,1,1);
	Out.ar(2,sig );
}).add;

SynthDef(\junglesnare, { arg out=0,tu=1, amp=0.1, gate=1, pan=0, freq=200,kracter = 10;
	var sig;
	var env = EnvGen.ar(Env([1,0,1,0],[0,0.004,0.05]),gate,doneAction:2);
	var enf = EnvGen.ar(Env([1600,5600,800,250],[0.001,0.001,0.001],-4));
	var enf2 = EnvGen.ar(Env([1000,1600,700,200],[0.001,0.001,0.06,0.01],-4));
	sig = SinOsc.ar(tu*enf+107,0,0.5)*env;
	sig =  WhiteNoise.ar(env)+sig;
	sig = RHPF.ar(sig, \hpf.kr(100)*tu, \rq2.kr(1))+sig;
	sig = sig + Mix.ar(BPF.ar(sig,[327,430],[0.5,0.5])*0.1)+WhiteNoise.ar(env)+BrownNoise.ar(env/8);
	sig = RLPF.ar(sig, \lpf.kr(11100)*tu, \rq.kr(0.5))+sig;
	sig =( Ringz.ar(WhiteNoise.ar,Mix.ar([enf2,enf*0.9,enf2*0.8]),1,0.01*env) +RLPF.ar(BrownNoise.ar(env),enf*4,1,1)+sig )*env ;
	sig = HPF.ar(sig,350);
	sig = CompanderD.ar(sig*kracter,0.8,0.3,0.5,0.001,0.2,env);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(2, sig);
}).add;

SynthDef(\t5snare, { arg out=0,tu=1, amp=0.3, gate=1, pan=0, freq=200,snd;
	var sig;
	var env = EnvGen.ar(Env.perc(0.01,1));
	var enf = EnvGen.ar(Env([600,177,230],[0.01,0.1],-4));
	//sig = SinOsc.ar(tu*enf+1207,0,0.5)*env;
	sig = WhiteNoise.ar;
	sig = FreeVerb.ar(sig,0.5,1);
	sig = RHPF.ar(sig, \hpf.kr(180)*tu, \rq.kr(0.5));
	sig = sig + Mix.ar(BPF.ar(sig,[127,430],[0.5,0.5])*0.1);
	sig = RLPF.ar(sig, \lpf.kr(12100)*tu, \rq.kr(0.5));
	sig = sig * EnvGen.ar(Env.perc(0,\rel.kr(0),-4),gate,doneAction:2);
//	sig = Pan2.ar(sig, pan, amp);
	sig = sig*amp;
	sig = CompanderD.ar(sig,1,1,0.1,0.01,0.4);
	sig = FreeVerb.ar(sig,1,1)+sig;
	Out.ar(2, sig*0.2*amp);
	//Out.ar(snd, sig);
}).add;


SynthDef(\snaremed, { | out = 2,level=1, pan=0, atk= 0.01,decay = 0.2,release=0.26, fratio=1.5,noise=1,done=2,freq1= 120,freq2=30,freq3=30,dc=1,aamp1=1,aamp2=1,aamp3=1,aamp4=1,curve1= (-4),curve2=(-2),curve3=(-4),famp1,famp2,famp3,famp4,p1,oamp=0.1,owhich2=0,ochoose=0|
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
son = HPF.ar(son, 100, env0);
	son = son + SelectX.ar(owhich2,[ SinOsc.ar(env1m, [p1,p2], env0), LFSaw.ar(env1m, [p1,p2], env0), LFPulse.ar(env1m, [p1,p2], env0), LFTri.ar(env1m, [p1,p2], env0)]);
	son =  HPF.ar(son +BrownNoise.ar(env0/2*noise)+WhiteNoise.ar(env0*noise),fratio);
//son = son.clip2(1);

	son = Limiter.ar(son,1);
	son = son * level.distort;
son = Pan2.ar(son, pan);

OffsetOut.ar(0, son*level).tanh;
OffsetOut.ar(20, son*level).tanh;


},
).add;

//CLAP



	SynthDef(\clap, {

  | outputChannels=0, amp = 0.5, pan=0, duré=1,sendChannels=0,	send=1, gate=1, q=0.1,fq=1,rnd1=0,rnd2=0,rnd3=0|
			var env1, env2, out, noise1, noise2;

	env1 = EnvGen.ar(\env1.kr(Env([0, 1, 0.5, 0.5, 0, 0, 0, 0, 0],	[0.001, 0.0013, 0, 0.1, 0, 0.001, 0, 0.0003],[0, -3, 0, -3, 0, -3, 0, -4])),doneAction:2);
			noise1 = WhiteNoise.ar(env1);
			noise1 = HPF.ar(noise1, 400);
			noise1 = BPF.ar(noise1, 1000*fq, 20*q);

	env2 = EnvGen.ar(\env2.kr(Env([0, 1, 0], [0.002, 0.01], [0, -4])),gate,	doneAction:2,);
			noise2 = WhiteNoise.ar(env2);
			noise2 = HPF.ar(noise2, 230	);
			noise2 = BPF.ar(noise2, 200*fq, 7*q, 0.7);



			out = noise1 + noise2;
			out = out * 2;
			out = out.softclip * amp;
			out=Pan2.ar(out,pan);
			OffsetOut.ar(outputChannels,[out[0]*send,out[1]*send]);
			OffsetOut.ar(24,[out[0]*send,out[1]*send]);
		}).add;

// hat
SynthDef(\hat,{arg gate = 1, amp=1, out=0,rel=0.1;
	var env = EnvGen.ar(Env.perc(0,rel),gate,doneAction:2);
	var freq = EnvGen.ar(Env([12000,80,20000],[0.1,0.1]));
	var sig = PinkNoise.ar(env);
	sig = HPF.ar(sig,freq);
	sig = sig.tanh;
	Out.ar(2,sig*amp*12);
}).add;



SynthDef(\hat808, {|out=0, freq=230, hpf=6500, release=0.15, amp=1, fxb=0, fxv=0, bbcb=0, bbcv=0|
  var pulse, sig, env, freqs;
  freqs = [freq, freq*1.4471, freq*1.617, freq*1.9265, freq*2.5028, freq*2.6637];
  pulse = Mix.ar(Pulse.ar(freqs, {0.9.rand}!6, mul: 1));
  sig = RHPF.ar(RHPF.ar(pulse, hpf), hpf);
  env = EnvGen.kr(Env.perc(0,release),doneAction:2);
  sig = sig*env;
  Out.ar(0, Pan2.ar(sig*amp,0));
}).add;

//rim

SynthDef(\rim, { arg out=0,tu=1, amp=0.01, pan=0,gate=1,rel=1;
	var sig;
	var env = EnvGen.ar(Env([1,0,1,0],[0,0.004,0.2]),gate,doneAction:2);
		var enf = EnvGen.ar(Env([1600,5600,800,250],[0.001,0.001,0.001],-4));
	var enf2 = EnvGen.ar(Env([1000,1600,700,200],[0.001,0.001,0.06,0.01],-4));
	sig = SinOsc.ar(tu*400)*env;
	sig =  WhiteNoise.ar(env)+sig;
	sig = RHPF.ar(sig, \hpf.kr(100)*tu, \rq2.kr(1))+sig;
	sig = sig + Mix.ar(BPF.ar(sig,[327,430],[0.5,0.5])*0.1)+WhiteNoise.ar(env)+BrownNoise.ar(env/8);
	sig = RLPF.ar(sig, \lpf.kr(11100)*tu, \rq.kr(0.5))+sig;
	sig =( Ringz.ar(WhiteNoise.ar,Mix.ar([enf2,enf*0.9,enf2*0.8]),1,0.01*env) +RLPF.ar(BrownNoise.ar(env),enf*4,1,1)+sig )*env ;
	sig = Pan2.ar(sig*env, pan, amp);
		sig = CompanderD.ar(sig*4,0.8,0.3,0.5,0.001,0.2,env);
	Out.ar(out, sig*amp);
}).add;

// notes

SynthDef(\notes,{arg freq = 69,gate = 1,tu = 1,level=1;
	var env = EnvGen.ar(Env.perc(0.01,0.1),gate,doneAction:2);
	var sig = WhiteNoise.ar(env);
	sig = CombL.ar(sig,0.2,(freq+(432.cpsmidi-69)).midicps/SampleRate.ir,1)+sig;
	sig = CombL.ar(sig,0.2,(freq+(432.cpsmidi-69)).midicps/SampleRate.ir,0.2)+sig;
	sig = sig *env *0.5;
	sig = CompanderD.ar(sig*2,0.5,1,0.5);
	Out.ar([0,1],sig*level);
}).add;

/////

SynthDef(\notes2,{arg notes,gate=1,at = 0.01,sus=0.4;
	var env = EnvGen.ar(Env.adsr(at,1,sus,1.4),gate,doneAction:2);
	var note = (notes+(432.cpsmidi-69)).midicps;
	var sig = Mix.ar(SinOsc.ar([note,note*2,note/2]));
	sig = Splay.ar(sig*0.1);
	Out.ar(0,sig*env);
	Out.ar(12,sig*env);
}).add;

SynthDef(\sinus,{arg out=0, freq=100,gate =1,release=0.1,lfo=1;
	var env  = EnvGen.ar(Env.perc(0,release),gate,doneAction:2);
	var sig = SinOsc.ar(freq.midicps+(432-69.midicps)*SinOsc.kr(lfo),0,env);
	sig = CompanderD.ar(sig,0.3,0.3,1.5,0.0001,0.01);
	Out.ar([0,1],sig);
}).add;

SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 ,pos=0,gate=1,speed=1,len=4.3,rel=0.1,pitch=1|
	var env = EnvGen.ar(Env([0,1,1,0],[0.1,len,rel]),gate,doneAction:2);
	var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*speed,1,pos, doneAction:2);
	Out.ar([0,1], PitchShift.ar(sig*env,0.2,pitch);
    )
}).add;


// samples


)