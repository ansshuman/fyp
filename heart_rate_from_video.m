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
magnifiedFile = amplify_spatial_Gdown_temporal_ideal(inFile,resultsDir,50,4, ...
                     50/60,60/60,30, 1);
 



%% Computing the red brightness signal
% second parmeter in acquire is the percentage of total length and width to be used for demarcating the central area used for analysing video 
[signalBrightnessAvg, frameRate] = acquire(magnifiedFile, 20);

%% Calculate heart rate
process(signalBrightnessAvg, frameRate);

%% Demo GUI
play_movies_together(1, 2, 30)