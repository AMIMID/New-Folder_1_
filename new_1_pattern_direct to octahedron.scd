
(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Pexprand(1,4,inf),
	\t,Pexprand(0.1,1,inf),
	\fundamental,Prand([220,440,880],inf),
	\a,Prand([1,2,3,4],inf),
	\z,Prand([1,2,3,4,5,6],inf),
	\xy,Prand([1,2,3,4,5,6],inf),
		\xy,Prand([1,2,3,4,5,6],inf);

)).play(quant:1))

/////////////////////////////synth
(SynthDef(\r0,{
	arg t=1,fundamental=440,xy=1,y=1,z=1,a=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1, duration=16, bend=(-3),  envelope=1, signalo=0,
	signal, sound,audio, position, amp, spat,azimuth,elevation,xysweep,xyzsweep,xyz;

	 signalo=PanAz.ar(2,SinOsc.ar(fundamental,mul:1),LFNoise1.ar(1));
	4.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = ((gain+x)/gain);
		duration=Complex(x,y2).abs;
		duration=duration+t;
		envelope=EnvGen.kr(Env.new([0,0.6,0.333,0.5,0], [duration], [bend]),doneAction:2);
		signalo=signalo*envelope;
		frequency=(fundamental/y1);
		amp=(gain/y2).postln;
		signal=SinOsc.ar(frequency, mul: amp)*envelope;
		spat = PanAz.ar(2,signal,LFNoise1.ar(Complex(y1,x).abs.postln));
		signalo=signalo +spat;
	};
		Out.ar(6,signalo);
		"xy".postln; xysweep=Complex(xy,y).magnitude.postln;"z".postln; z=((xysweep+a)/xysweep).postln;
	   "xyz".postln; xyzsweep=Complex(xysweep,z).abs.postln;
	phi=LFSaw.ar(); ,  theta=LFSaw.ar();
	elevation=PanAz.ar(2,InFeedback.ar(6,1),xyzsweep*phi); , azimuth=PanAz.ar(4,InFeedback.ar(7,1),xysweep*theta);
	Out.ar(0,elevation); Out.ar(2,azimuth);
}).add)


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=8;