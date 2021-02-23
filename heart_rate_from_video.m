% heart_rate_from_video.m
clear all;
clc;
%make;
%install;


dataDir = './tests';
resultsDir = 'results';
mkdir(resultsDir);
%% face
inFile = fullfile(dataDir,'face.mp4');
fprintf('Processing %s\n', inFile);
inFile = amplify_spatial_Gdown_temporal_ideal(inFile,resultsDir,50,4, ...
                     65/60,80/60,30, 1);

vidFile = inFile;

% Read video
vid = VideoReader(vidFile);
% See the values
% vid
% Extract video info
vidHeight = vid.Height;
vidWidth = vid.Width;
nChannels = 3;
fr = vid.FrameRate;
len = vid.NumFrames;
temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

% Set up info for FFT
T = 1/fr;
tlen = len/fr;
t1 = linspace(0, tlen, len);
f = -fr/2:fr/len:fr/2-fr/len;
 
% Now here's' the stuff to get heart rate.
% Make our own struct and variable to use for the graphs
mov(1:len) = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

% Grab all the frames and put into our struct
for k = 1 : len
    mov(k).cdata = read(vid, k);
end

% Find the center 5th to average
centerVerMin = ceil((vidHeight/5) + (vidHeight/5));
centerVerMax = ceil((vidHeight/5) + (vidHeight/5) + (vidHeight/5));

centerHorMin = ceil((vidWidth/5) + (vidWidth/5));
centerHorMax = ceil((vidWidth/5)  + (vidWidth/5) + (vidWidth/5));

sampleHor = centerHorMax - centerHorMin;
sampleVer = centerVerMax - centerVerMin;

sample = zeros(sampleVer, sampleHor, len);
t = zeros(len);
avg = zeros(len);

for k = 1 : len
    for j = centerHorMin : centerHorMax
        for i = centerVerMin : centerVerMax
            sampleHorIndex = j - centerHorMin + 1;
            sampleVerIndex = i - centerVerMin + 1;
            sample(sampleVerIndex, sampleHorIndex, k) = mov(k).cdata(i, j, 1);
        end
    end
    t(k) = k;   % value of k (frames) for graphing
    avg(k) = mean(mean(sample(:,:,k)));
end



Y = fftshift(fft(avg));

figure
subplot(2,1,1)
plot(t,avg)
title('Intensity of Center Pixel vs Frame'); xlabel('Frame'); ylabel('Pixel intensity');

% This works, but shows a lot of useless frequencies
% Zoom into around x = 1, and you will see the heart beat is about 
% 0.9 Hz which needs to be converted to BPM (0.9*60 = 54 BPM)
subplot(2,1,2)
xlim([0, 1])
ylim([0,7])
stem(f, abs(Y)/len, 'filled')
title('Magnitude of Frequency to find Heart Rate'); xlabel('Frequency (Hz)'); ylabel('Magnitude');




