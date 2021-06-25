(a= Pdef(\voice_1, Pbind(\instrument, \v0,
	\dur,Prand([3,5,8],inf),
	\fundamental,Prand([3,5,8],inf),
	\a,Prand([3,5,8],inf);
)).play(quant:1))


(SynthDef(\v0,{
	arg fundamental=2,a=1,pan1=1,pan2=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1/2, duration=6, bend=(-3),  envelope=1,mul=1,signal=0,w,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,pan,azimuth1,azimuth2;

	fundamental=fundamental*320;

	6.do{
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		duration= y1;
		envelope=EnvGen.kr(Env.new([0,1,0.6,0.4,0], [duration], [bend]),doneAction:2);
		mono=SinOsc.ar(frequency,mul: mul)*envelope;
		signal=LFSaw.ar(frequency)*envelope;
		sound=sound +mono;
		spat=spat+signal;
		sound=sound*envelope;
		spat=spat*envelope;
	};


	//Out.ar(6,sound);
//	Out.ar(7,spat);
//	azimuth = PanAz.ar(3,InFeedback.ar(6),pos:InFeedback.ar(7));
//	Out.ar(3,azimuth);
//	audio = PanAz.ar(3,Mix.new([InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5)]),LFSaw.ar(MouseX.kr(0.1,10)));
//	Out.ar(0,audio);
	pan1= (MouseX.kr(0.1,10));
	pan2= (MouseY.kr(0.1,10));
	pan= Complex(pan1,pan2).magnitude;
	w=PanAz.ar(4,sound*1/20,LFSaw.ar(20));
	Out.ar(0,w);
	tone = PanAz.ar(3,sound,LFSaw.ar(pan1));
	Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan2));
	Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19));
	Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20));
	Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21));
	Out.ar(11,azimuth2);
	time = PanAz.ar(2,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	Out.ar(0,time);


}).add)


s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=22;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////task with patterna
(
Tdef(\1,
      {

		1.do({(e= Pdef(\voice_1, Pbind(\instrument, \v0,
	\dur,Prand([2],inf),
        \ton, Prand([220],inf),
	\a,Pseq([1,2,3,4,5],inf),
	\pan,Prand([5/6,6/7,7/8,8/9],inf);

)).play(quant:1));
	(3).yield});

		 1.do({(f= Pdef(\voice_2, Pbind(\instrument, \v1,
			\dur,Prand([3],inf),
        \ton, Prand([220],inf),
	\a,Pseq([1,2,3,4,5],inf),
	\detune,Pexprand([0.1,2],inf),
		\pan,Prand([5/6,6/7,7/8,8/9],inf);
)).play(quant:1));

		2.yield});

				 1.do({(f= Pdef(\voice_3, Pbind(\instrument, \v2,
	\dur,Prand([5],inf),
        \ton, Prand([220],inf),
	\a,Pseq([1,2,3,4,5],inf),
	\detune,Pexprand([0.1,2],inf),
		\pan,Prand([5/6,6/7,7/8,8/9],inf);
)).play(quant:1));

		1.yield});
	})
)
Tdef(\1).play


(;
//////synth

(
(SynthDef(\v2,{
arg ton=220,a=1,pan=1,dur;
	var frequency=1, x=0, y=0, gain=1/30, duration=6, bend=(-11),  envelope=1,mul=1,signal=0,saw,amp,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton/3;
	ton=ton*2;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);saw=ton*x; amp=gain/saw;
		envelope=EnvGen.kr(Env.perc(0.06,duration*3,1,bend),doneAction:2); mono=SinOsc.ar(frequency,mul: mul,phase:3pi/2)*envelope;
		signal=BLowPass.ar(LFSaw.ar(saw,iphase:3pi/2,mul:amp),ton)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	//Out.ar(6,sound);	Out.ar(7,spat);	azimuth = PanAz.ar(3,InFeedback.ar(6),pos:InFeedback.ar(7));	Out.ar(3,azimuth);	audio =PanAz.ar(3,Mix.new([InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5)]),LFSaw.ar(MouseX.kr(0.1,10)));Out.ar(0,audio);
	pan=pan*MouseX.kr(1,100);
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(2,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	Out.ar(0,time*gain);
}).add);


(SynthDef(\v1,{
arg ton=220,a=1,pan=1,dur;
	var frequency=1, x=0, y=0, gain=1/20 ,duration=6, bend=(-11),  envelope=1,mul=1,signal=0,saw,amp,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton/2;
		ton=ton*2;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);saw=ton*x; amp=gain/saw;
		envelope=EnvGen.kr(Env.perc(0.05,duration*6,1,bend),doneAction:2); mono=SinOsc.ar(frequency,mul: mul,phase:pi/2)*envelope;
		signal=BLowPass.ar(LFSaw.ar(saw,iphase:pi/2,mul:amp),ton)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	//Out.ar(6,sound);	Out.ar(7,spat);	azimuth = PanAz.ar(3,InFeedback.ar(6),pos:InFeedback.ar(7));	Out.ar(3,azimuth);	audio =PanAz.ar(3,Mix.new([InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5)]),LFSaw.ar(MouseX.kr(0.1,10)));Out.ar(0,audio);
	pan=pan*MouseX.kr(1,100);
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(2,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	Out.ar(0,time*gain);
}).add);
(SynthDef(\v0,{
arg ton=220,a=1,pan=1,dur;
	var frequency=1, x=0, y=0, gain=1/10, duration=6, bend=(-11),  envelope=1,mul=1,signal=0,saw,amp,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton/1;
		ton=ton*2;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);saw=ton*x; amp=gain/saw;
		envelope=EnvGen.kr(Env.perc(0.05,duration*9,1,bend),doneAction:2); mono=SinOsc.ar(frequency,mul: mul)*envelope;
	signal=BLowPass.ar(LFSaw.ar(saw,mul:amp),ton)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	//Out.ar(6,sound);	Out.ar(7,spat);	azimuth = PanAz.ar(3,InFeedback.ar(6),pos:InFeedback.ar(7));	Out.ar(3,azimuth);	audio =PanAz.ar(3,Mix.new([InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5)]),LFSaw.ar(MouseX.kr(0.1,10)));Out.ar(0,audio);
	pan=pan*MouseX.kr(1,100);
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(2,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	Out.ar(0,time*gain);


}).add)
)


s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=22;