TempoClock.default.tempo_(120/110);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=11;
s.options.numInputBusChannels=0;

g.free

(g= Pdef(\voice_3, Pbind(\instrument, \v3,
	\dur,Prand([1],inf),
        \ton, Prand([28],inf),
	\a,Pseq([2,3,5,8],inf),
	\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);
)).play(quant:1))


(SynthDef(\v3,{
arg ton=220,a=1,pan=1,dur,offset=1,pan1=1,pan2=1;
	var frequency=1, x=0, y=0, gain=1/10, duration=6, bend=(-11),  envelope=1,mul=1,signal=0,x1=0,y1=0,frequency1=1,duration1=6,envelope1,bend1=(-11),mul1=1,stereo=0,dual=0,
	sound=0,spat=0,elevation,azimuth1,azimuth2,mono;
		ton=ton;
	ton=ton+offset;
		2.do{
		x=x+1;
		y = ((x+a)/x);
		frequency=(y*ton);
		mul=(gain/y);
		duration= (y.squared);
		bend= (0-duration);
		envelope=EnvGen.kr(Env.perc(0.06,duration*1,1,bend),doneAction:2);
		mono=SinOsc.ar(frequency,mul: mul,phase:3pi/2)*envelope;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		sound=sound +mono; sound=sound*envelope;
	};
	Out.ar(6,sound);
	3.do{
			x1=x1+1;
		y1 = ((x1+a)/x1);
		mul1=(gain/y1);
		duration1= (y1.squared);
		bend1= (0-duration1);
		 frequency1=(y1*ton);
		envelope1=EnvGen.kr(Env.perc(0.6,duration1*1,1,bend1),doneAction:2);
		dual = PitchShift.ar(InFeedback.ar(6),pitchRatio:y1);
	stereo = stereo +dual; stereo=stereo*envelope1;
		signal=BLowPass.ar(LFSaw.ar(frequency1,iphase:0pi,mul:mul1),ton)*envelope1;
		spat=spat+signal; spat=spat*envelope1;
	};
	pan=MouseY.kr(0.01,10);
	elevation = PanAz.ar(2,signal,pan);
	Out.ar(9,elevation);
	dual = PanAz.ar(2,stereo,InFeedback.ar(9));
	Out.ar(7,dual);
	azimuth1=PanAz.ar(3,InFeedback.ar(7),pos:InFeedback.ar(9));
	Out.ar(0,azimuth1);
	azimuth2=PanAz.ar(3,InFeedback.ar(8),pos:InFeedback.ar(10));
	Out.ar(3,azimuth2);


}).add)