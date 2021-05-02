% heart_rate_from_video.m
clear all;
clc;
% make;
% install;


dataDir = './tests';
resultsDir = 'results';
% mkdir(resultsDir);


%% input Video
inFile = fullfile(dataDir,'face.mp4');


%% Spatial filtering
fprintf('Processing %s\n', inFile);
amplify_spatial_Gdown_temporal_ideal(inFile,resultsDir,50,4, ...
                     65/60,80/60,30, 1);
 

%% Read color magnified video
inFile = fullfile(resultsDir, 'face-ideal-from-1.0833-to-1.3333-alpha-50-level-4-chromAtn-1.avi');
vid = VideoReader(inFile);
% Extract video info
vidHeight = vid.Height;
vidWidth = vid.Width;
nChannels = 3;
fr = vid.FrameRate;
len = vid.NumFrames;

%% Computing the red brightness signal
signalBrightnessAvg = acquire(inFile);

%% Calculate heart rate
process(signalBrightnessAvg, vid.FrameRate);

%% Demo GUI

