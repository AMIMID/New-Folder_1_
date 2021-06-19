(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Prand([1,2,3],inf),
	\fundamental,Prand([6,8,9,12],inf),
	\a,Prand([1,2,3,4],inf);

)).play(quant:1))

/////////////////////////////synth
(SynthDef(\r0,{
	arg t=1,fundamental=330,xy=1,y=1,z=1,a=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1, duration=16, bend=(-3),  envelope=1, signalo=0,bus=0,
	signal, sound,audio, position, amp, spat,azimuth,elevation,xysweep,xyzsweep,xyz,theta,phi;

	 signalo=0;//PanAz.ar(2,SinOsc.ar(fundamental,mul:1),LFNoise1.ar(1));
	fundamental=fundamental*666;
	4.do{
		//bus=bus+2;
		x=x+1;
		y1 = ((x+a)/x);  frequency=(fundamental/y1);
		y2 = ((gain+x)/gain); 	amp=(gain/y2);
		theta = ((Complex(y2,y1).abs)+x)/(Complex(y2,y1).abs);
		duration=theta*2;	envelope=EnvGen.kr(Env.sine(duration),doneAction:2);
		signal=SinOsc.ar(frequency, mul: amp)*envelope;
		spat = PanAz.ar(2,signal,LFSaw.ar(theta))*envelope;
		signalo=signalo +spat;
		signalo = signalo*envelope;

	};
	Out.ar(bus,signalo);
	//	"xy".postln; xysweep=Complex(xy,y).magnitude.postln;"z".postln; z=((xysweep+a)/xysweep).postln;
	//   "xyz".postln; xyzsweep=Complex(xysweep,z).abs.postln;
	//phi=LFSaw.ar(frequency/1000);  theta=LFSaw.ar(frequency/2000);
	//elevation=PanAz.ar(2,InFeedback.ar(6)*envelope,xyzsweep*phi); azimuth=PanAz.ar(4,InFeedback.ar(7)*envelope,xysweep*theta);
	//Out.ar(0,elevation); Out.ar(2,azimuth);
}).add)


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=8;