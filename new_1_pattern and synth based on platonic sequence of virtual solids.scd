(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Prand([1,2,3],inf),
	\fundamental,Prand([6,8,9,12],inf),
	\a,Prand([1,2,3,4],inf);

)).play(quant:1))

/////////////////////////////synth
(SynthDef(\r0,{
	arg t=1,fundamental=330,xy=1,y=1,z=1,a=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1, duration=6, bend=(-3),  envelope=1, signalo=0,mul=1,signalo=0;
	signal, sound, dual,elevationcube,upcube,downcube,azocta1,azocta2,azocta3,azocta4,azocta5,azocta6,azocta7,azocta8;
	fundamental=fundamental*666;
	4.do{
		//bus=bus+2;
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		theta = ((Complex(y2,y1).abs)+x)/(Complex(y2,y1).abs);
		duration=theta*2;
		envelope=EnvGen.kr(Env.sine(duration),doneAction:2);
		signal=SinOsc.ar(frequenc,mul: mul)*envelope;
		dual = PanAz.ar(4,signal,LFSaw.ar(elevationcube))*envelope;
		signalo=signalo +spat;
		signalo = signalo*envelope;
	};
	Out.ar(14,signalo);
	upcube= PanAz.ar(4,InFeedback.ar(14),pos:LFSaw.ar());
	downcube= PanAz.ar(4,InFeedback.ar(15),pos:LFSaw.ar());
	Out.ar(6,upcube);
	Out.ar(10,downcube);
	azocta1= PanAz.ar(6,InFeedback.ar(6),pos:LFSaw.ar());
	azocta2= PanAz.ar(6,InFeedback.ar(7),pos:LFSaw.ar());
	azocta3= PanAz.ar(6,InFeedback.ar(8),pos:LFSaw.ar());
	azocta4= PanAz.ar(6,InFeedback.ar(9),pos:LFSaw.ar());
	azocta5= PanAz.ar(6,InFeedback.ar(10),pos:LFSaw.ar());
	azocta6= PanAz.ar(6,InFeedback.ar(11),pos:LFSaw.ar());
	azocta7= PanAz.ar(6,InFeedback.ar(12),pos:LFSaw.ar());
	azocta8= PanAz.ar(6,InFeedback.ar(13),pos:LFSaw.ar());
	Out.ar(0,azocta1);
	Out.ar(0,azocta2);
	Out.ar(0,azocta3);
	Out.ar(0,azocta4);
	Out.ar(0,azocta5);
	Out.ar(0,azocta6);
	Out.ar(0,azocta7);
	Out.ar(0,azocta8);
}).add)


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("SAMSUNG");
s.options.numOutputBusChannels=8;

////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Prand([1,2,3],inf),
	\fundamental,Prand([6,8,9,12],inf),
	\a,Prand([1,2,3,4],inf);

)).play(quant:1))

/////////////////////////////synth
(SynthDef(\r0,{
	arg t=1,fundamental=330,xy=1,y=1,z=1,a=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1, duration=6, bend=(-3),  envelope=1, signalo=0,mul=1,signal=0;
	signal, sound, dual,icosaeder,azocta1,azocta2,azocta3,azocta4,azocta5,azocta6;
	fundamental=fundamental*666;
	12.do{
		//bus=bus+2;
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		theta = ((Complex(y2,y1).abs)+x)/(Complex(y2,y1).abs);
		duration=theta*2;
		envelope=EnvGen.kr(Env.sine(duration),doneAction:2);
		sound=SinOsc.ar(frequenc,mul: mul)*envelope;
		dual = PanAz.ar(6,sound,LFSaw.ar(icosaeder))*envelope;
		signal=signal +dual;
		signal = signal*envelope;
	};
	Out.ar(24,signalo);
	azocta1= PanAz.ar(4,InFeedback.ar(24),pos:LFSaw.ar());
	azocta2= PanAz.ar(4,InFeedback.ar(25),pos:LFSaw.ar());
	azocta3= PanAz.ar(4,InFeedback.ar(26),pos:LFSaw.ar());
	azocta4= PanAz.ar(4,InFeedback.ar(27),pos:LFSaw.ar());
	azocta5= PanAz.ar(4,InFeedback.ar(28),pos:LFSaw.ar());
	azocta6= PanAz.ar(4,InFeedback.ar(29),pos:LFSaw.ar());
	Out.ar(0,azocta1);
	Out.ar(4,azocta2);
	Out.ar(8,azocta3);
	Out.ar(12,azocta4);
	Out.ar(16,azocta5);
	Out.ar(20,azocta6);
}).add)