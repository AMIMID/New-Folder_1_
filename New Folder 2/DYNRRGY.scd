
TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=18;
s.options.memSize = 65536
s.options.numInputBusChannels=0;
Tdef(\1).play

(
(
Tdef(\1,
      {

		 1.do({(g= Pdef(\voice_3, Pbind(\instrument, \v3,
	\dur,Prand([1],inf),
        \ton, Prand([220,110,440],inf),
	\a,Pseq([2,3,5,8,2,5,8,2],inf),
)).play(quant:1));

	(1/2).yield});

				 1.do({(f= Pdef(\voice_4, Pbind(\instrument, \v4,
	\dur,Prand([1],inf),
        \ton, Prand([220,110,440],inf),
	\a,Pseq([2,3,5,8,2,5,8,2],inf);
	\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);
)).play(quant:1));

			(1).yield});


	})
);

(
(SynthDef(\v4,{
arg ton=220,a=1,dur,offset=1,pan1=1,pan2=1;
	var frequency1=1, x1=0, y1=0, gain1=1/100, duration1=6,  envelope1=1,mul1=1,spat1=0, stereo=0, dual=0, sound=0,azimuth1,azimuth2,mono,oktahedron,cube1,cube2,spat,
	      frequency2=1, x2=0, y2=0, gain2=1/100, duration2=6,  envelope2=1,mul2=1,spat2=0,signal1,elevation,audio,
	      frequency3=1, x3=0, y3=0, gain3=1/100, duration3=6,  envelope3=1,mul3=1,spat3=0,quad=0,quad1=0,signal2;

		pan1=MouseX.kr(0.1,4);
	pan2=MouseY.kr(0.1,4);
	ton=ton+offset;
	//ton=ton+offset;
		2.do{
		x1=x1+1;
		y1= ((x1+a)/x1);
		frequency1=(y1*ton);
		mul1=(gain1/y1);
		duration1= (y1.cubed);
		envelope1=EnvGen.kr(Env.sine(duration1,1),doneAction:2);
		mono=SinOsc.ar(frequency1,mul: mul1,phase:3pi/2)*envelope1;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		sound=sound +mono; sound=sound*envelope1;
	};

	3.do{
		x2=x2+1;
	y2 = ((x2+a)/x2).postln;
	mul2=(gain2/y2);
	duration2= (y2.cubed);
	 frequency2=(y2*ton);
	envelope2=EnvGen.kr(Env.sine(duration2),doneAction:2);
		stereo = SinOsc.ar(frequency2,mul: mul2,phase:3pi/2)*envelope2;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
	stereo = stereo +dual; stereo=stereo*envelope2;
		signal1=BLowPass.ar(LFSaw.ar(mul2))*envelope2;
		spat1=spat1+signal1; spat1=spat1*envelope2;
	};

	4.do{
		x3=x3+1;
	y3 = ((x3+a)/x3).postln;
	mul3=(gain3/y3);
	duration3= (y3.cubed);
	 frequency3=(y3*ton);
	envelope3=EnvGen.kr(Env.sine(duration3),doneAction:2);
		quad1 = SinOsc.ar(frequency3,mul: mul3,phase:3pi/2)*envelope3;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
	quad = quad +quad1; quad=quad*envelope3;
		signal2=BLowPass.ar(LFSaw.ar(mul3))*envelope3;
		spat2=spat2+signal2; spat2=spat2*envelope3;
	};

	oktahedron = quad+stereo+mono+(SinOsc.ar(ton,mul:1));
	spat = spat2 + spat1;
	Out.ar(9,PanAz.ar(2,oktahedron,spat));
	cube1=PanAz.ar(4,InFeedback.ar(9),spat); Out.ar(10,cube1);
	cube2=PanAz.ar(4,InFeedback.ar(10),spat);Out.ar(14,cube2);
	Out.ar(0,PanAz.ar(2,Mix.new([InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15),InFeedback.ar(16),InFeedback.ar(17)]),spat));

}).add);
(SynthDef(\v3,{
arg ton=220,a=1,dur,offset=1,pan1=1,pan2=1;
	var frequency1=1, x1=0, y1=0, gain1=1/100, duration1=6,  envelope1=1,mul1=1,spat1=0, stereo=0, dual=0, sound=0,azimuth1,azimuth2,mono,oktahedron,cube,spat,
	      frequency2=1, x2=0, y2=0, gain2=1/100, duration2=6,  envelope2=1,mul2=1,spat2=0,signal1,elevation,audio,
	      frequency3=1, x3=0, y3=0, gain3=1/100, duration3=6,  envelope3=1,mul3=1,spat3=0,quad=0,quad1=0,signal2;

		pan1=MouseX.kr(0.1,4);
	pan2=MouseY.kr(0.1,4);
	ton=ton;
	//ton=ton+offset;
		2.do{
		x1=x1+1;
		y1= ((x1+a)/x1);
		frequency1=(y1*ton);
		mul1=(gain1/y1);
		duration1= (y1.cubed);
		envelope1=EnvGen.kr(Env.sine(duration1,1),doneAction:2);
		mono=SinOsc.ar(frequency1,mul: mul1,phase:3pi/2)*envelope1;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		sound=sound +mono; sound=sound*envelope1;
	};

	3.do{
		x2=x2+1;
	y2 = ((x2+a)/x2).postln;
	mul2=(gain2/y2);
	duration2= (y2.cubed);
	 frequency2=(y2*ton);
	envelope2=EnvGen.kr(Env.sine(duration2),doneAction:2);
		stereo = SinOsc.ar(frequency2,mul: mul2,phase:3pi/2)*envelope2;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
	stereo = stereo +dual; stereo=stereo*envelope2;
		signal1=BLowPass.ar(LFSaw.ar(mul2))*envelope2;
		spat1=spat1+signal1; spat1=spat1*envelope2;
	};

	4.do{
		x3=x3+1;
	y3 = ((x3+a)/x3).postln;
	mul3=(gain3/y3);
	duration3= (y3.cubed);
	 frequency3=(y3*ton);
	envelope3=EnvGen.kr(Env.sine(duration3),doneAction:2);
		quad1 = SinOsc.ar(frequency3,mul: mul3,phase:3pi/2)*envelope3;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
	quad = quad +quad1; quad=quad*envelope3;
		signal2=BLowPass.ar(LFSaw.ar(mul3))*envelope3;
		spat2=spat2+signal2; spat2=spat2*envelope3;
	};

oktahedron = quad+stereo+mono+(SinOsc.ar(ton,mul:1));
spat = spat2 + spat1;
	Out.ar(2,PanAz.ar(6,oktahedron,spat));
	Out.ar(0,PanAz.ar(2,Mix.new([InFeedback.ar(2),InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7)]),spat));

}).add);
)
)