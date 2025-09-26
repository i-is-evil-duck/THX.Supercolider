i wanted to recreate the THX sound :D 



~mamp = 1.0;

(
SynthDef.new(\thxStereo, {
    arg out = 0, ffreqL = 2000, ffreqR = 2000, amp = 0.2, group = 0;
    var sigL, sigR, envL, envR, afreqL, afreqR, freqL, freqR, detuneL, detuneR;

    // LEFT CHANNEL
    afreqL = Rand(200, 400);
    freqL = Line.kr(afreqL, ffreqL, 20);
    detuneL = Rand(0.99, 1.01);
    freqL = freqL * detuneL;
    envL = Select.kr(
        group,
        [
            EnvGen.kr(Env.new([0.001, 0.07, 2, 0.001], [1, 17, 9, 4], [1, 1, 1, -1]), doneAction: 2),
            EnvGen.kr(Env.new([0.001, 0.05, 2, 0.001], [6, 12, 9, 4], [1, 1, 1, -1]), doneAction: 2)
        ]
    );
    sigL = Saw.ar(freqL) * amp * envL * ~mamp;

    // RIGHT CHANNEL
    afreqR = Rand(200, 400);
    freqR = Line.kr(afreqR, ffreqR, 20);
    detuneR = Rand(0.99, 1.01);
    freqR = freqR * detuneR;
    envR = Select.kr(
        group,
        [
            EnvGen.kr(Env.new([0.001, 0.07, 2, 0.001], [1, 17, 9, 4], [1, 1, 1, -1]), doneAction: 2),
            EnvGen.kr(Env.new([0.001, 0.07, 2, 0.001], [6, 12, 9, 4], [1, 1, 1, -1]), doneAction: 2)
        ]
    );
    sigR = Saw.ar(freqR) * amp * envR * ~mamp;

    // Output stereo: Left = sigL, Right = sigR
    Out.ar(out, [sigL, sigR]);
}).add;
)
(
var group0 = [26, 38, 45, 50];
var group1 = [57, 62, 69, 74, 81, 86, 90];

group0.do { |note|
    3.do {
        Synth(\thxStereo, [
            \ffreqL, note.midicps,
            \ffreqR, (note).midicps,
            \group, 0
        ]);
    };
};

group1.do { |note|
    3.do {
        Synth(\thxStereo, [
            \ffreqL, note.midicps,
            \ffreqR, (note).midicps,
            \group, 1
        ]);
    };
};
)
