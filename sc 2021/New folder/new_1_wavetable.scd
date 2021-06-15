Env([-1,0,1],[(1*((3/2)-(4/3))),(1*((3/2)-(4/3)))],[-5,5]).plot;//.asSignal(1024+1).plot
Env.sine.plot;


~b0 = Buffer.alloc(s,2048);
~tf = Env([-1,0,1],[0.1,0.1],[-10,10]).asSignal(1025);
~tf.plot;
~tf = ~tf.asWavetableNoWrap;
~tfBuf = Buffer.loadCollection(s,~tf);~b0.numFrames;
{Shaper.ar(~tfBuf, SinOsc.ar(220)*Line.kr(0,1,10),mul:1)}.play;

//////////////////////////////////////////////////////////////////////////


Env([-1,0,1,0,-1],[1,1,1,1],[4,-4,4,-4]).plot;//.asSignal(1024+1).plot




{VarSaw.ar(220,MouseX.kr(0,1),width:MouseX.kr(0,1))}.play