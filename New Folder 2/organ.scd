(a= Pdef(\voice_1, Pbind(\instrument, \v0,
	\dur,Prand([3,5,8],inf),
	\fundamental,Prand([3,5,8],inf),
	\a,Prand([3,5,8],inf);
)).play(quant:1))


(SynthDef(\v0,{
	arg fundamental=2,a=1,pan1=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1/2, duration=6, bend=(-3),  envelope=1,mul=1,signal=0,w,
	mono,pan3,sound=0,spat=0,azimuth,elevation,tone;

	fundamental=fundamental*240;

	3.do{
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		duration= y1;
		envelope=EnvGen.kr(Env.new([0,1,0.6,0.4,0], [duration], [bend]),doneAction:2);
		mono=SinOsc.ar(frequency,mul: mul)*envelope;
		signal=LFSaw.ar(fundamental*y1,mul:mul);
		sound=sound +mono;
		spat=spat+signal;
		sound=sound*envelope;
		spat=spat*envelope;
	};

	w=PanAz.ar(3,sound*1/13,SinOsc.ar(1));
	Out.ar(0,w);
	Out.ar(3,sound*0.5);
	Out.ar(4,spat);
	azimuth = PanAz.ar(3,InFeedback.ar(3),pos:LFSaw.ar(MouseX.kr(1/2,2)+InFeedback.ar(4)));
	Out.ar(0,azimuth);

}).add)


s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=5;