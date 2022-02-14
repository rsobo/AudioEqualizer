%load in audio
file = uigetfile('*.wav');
[lotr, Fs] = audioread(file);
%define the frequency bands
freqBands = [31.25, 62.5, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
%create an array of 0's for the gains
gainz = zeros(size(freqBands));
for i = (1:10)
   gainz(i) = randi([-60,60]); 
end
%sets helper variables
freqResolution = 3;
N = ceil(Fs/freqResolution);
freqs = (0:N-1)'/N;
%creates the discrete part of the response
discBand(1:10) = freqBands/Fs;
discBand(11:20) = 1-(flip(discBand(1:10)));
%creates a mirrored look of the discrete graph
mirrorGainz(1:10) = 10.^(gainz/20);
mirrorGainz(11:20) = flip(10.^(gainz/20));
%interpolates the discrete and mirrored arrays
H = interp1(discBand, mirrorGainz ,freqs,"linear","extrap");
%plot the frequency vs the inverse forier 
plot(freqs*Fs,20*log10(H));
xlabel('Frequencies');
ylabel('H(f)');