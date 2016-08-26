
SynthDef(\playbuf, {| out = 0, bufnum = 0 ,pos=0,gate=1,speed=1,len=4.3,rel=0.1,pitch=1,level=1|
	var env = EnvGen.ar(Env([0,1,1,0],[0.1,len,rel]),gate,doneAction:2);
	var sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*speed,1,pos, doneAction:2);
	Out.ar(out, PitchShift.ar(sig*env,0.2,pitch)*level;
    )
}).add;



