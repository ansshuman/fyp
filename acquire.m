function [brightness, frameRate] = acquire(video_file, percentArea)

    if ischar(video_file)
        disp(['Loading file ' video_file]);
        video = VideoReader(video_file);
    else
        video = video_file;
    end
    vidHeight = video.Height;
    vidWidth = video.Width;
    numFrames = video.NumberOfFrames;
    frameRate = video.FrameRate;
    
    display(['Total frames: ' num2str(numFrames)]);
    
    % Find the central percentage area indices to average
    if(percentArea < 0 && percentArea > 100)
        percentArea = 100;
    end
    centerVerMin = ceil((50 - percentArea/2)/100 * vidHeight);
    centerVerMax = ceil((50 + percentArea/2)/100 * vidHeight);

    centerHorMin = ceil((50 - percentArea/2)/100 * vidWidth);
    centerHorMax = ceil((50 + percentArea/2)/100 * vidWidth);
    
    if(centerVerMin == 0)
        centerVerMin = 1;
        centerHorMin = 1;
    end

    sampleHor = centerHorMax - centerHorMin;
    sampleVer = centerVerMax - centerVerMin;
    
    disp(['Processing frames'])
    % make 1D array of ROI averages
    brightness = zeros(1, numFrames);
    for i=1:numFrames
        %display(['Processing ' num2str(i) '/' num2str(numFrames)]);
        frame = read(video, i);
        greenPlane = zeros(sampleVer, sampleHor);
        for j = centerHorMin : centerHorMax
            for k = centerVerMin : centerVerMax
                sampleHorIndex = j - centerHorMin + 1;
                sampleVerIndex = k - centerVerMin + 1;
                greenPlane(sampleVerIndex, sampleHorIndex) = frame(k, j, 2);   % picking out the green part in central percentage area selected for all frames
            end
        end
        brightness(i) = sum(sum(greenPlane)) / (sampleHor * sampleVer);   
    end

    disp('Signal acquired.');
    disp(' ');
    disp(['Sampling rate is ' num2str(frameRate) '.']);

end