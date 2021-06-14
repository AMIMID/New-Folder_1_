//////////////from partial_new_1
//////////////////////////////////////////////////////////////////////////11 amp and freq on same graph //ORGAN// octave as notes
(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,
	x=0,y1=0,y2=0,
	fundamental,amp,
	gain=1,octave=1,radiai=8,partials=2;

	"fundamental".postln;  fundamental = (radiai/partials).postln;
	fundamental =fundamental *220; ////could be midicps and a the octave up down without affect to cps
	a= octave;      sum=SinOsc.ar(fundamental,mul:1);      partials=partials*4;
	partials.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = (gain/x);
		"freq".postln;     freq=(fundamental/y1).postln;
		"amp".postln;    amp=(gain*y2).postln;
		temp=SinOsc.ar( freq, mul: amp);
		sum=sum +temp};
	Out.ar(0,sum*(1/2));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)
///////////////////////////////////as wave  fundamental as notes

(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,
	x=0,y1=0,y2=0,
	fundamental,amp,
	gain=1,octave=2,radiai=16,partials=8;

	"fundamental".postln;  fundamental = (radiai/partials).postln;
	fundamental =fundamental *110; ////could be midicps and a the octave up down without affect to cps
	a= octave;      sum=SinOsc.ar(fundamental,mul:1);      partials=partials;
	partials.do{
		x=x+1;
		y1 = (gain/x);
		y2 = ((x+a)/x);
		"freq".postln;     freq=(fundamental/y1).postln;
		"amp".postln;    amp=(y1).postln;
		temp=SinOsc.ar( freq*y2, mul: amp);
		sum=sum +temp};
	Out.ar(0,sum);
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)
/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
s.options.numOutputBusChannels=12;



