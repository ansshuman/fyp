v1 = VideoReader('tests/face.mp4');
v2 = VideoReader('results/face-ideal-from-0.83333-to-1-alpha-50-level-4-chromAtn-1.avi');
i1 = 0;
i2 = 0;
fig = figure('Position', [100, 100, 1000, 1000]);
ax1 = subplot(2,2,1, 'Parent', fig);
ax2 = subplot(2,2,2, 'Parent', fig);
% To do notes to self : make this while loop trigger after every 1 second, look into
% 'timer' in evening, also look 

while i1 < v1.NumFrames && i2 < v2.NumFrames
    
            i1 = i1+1;
            if isgraphics(ax1)
              image(ax1, v1.read(i1));
            else
              break;    %axes is gone, figure is probably gone too
            end
            if(i1 == v1.NumFrames)
                i1 = 0;
            end
            
            i2 = i2+1;
            if isgraphics(ax2)
              image(ax2, v2.read(i2));
            else
              break;    %axes is gone, figure is probably gone too
            end
            if(i2 == v2.NumFrames)
               i2 = 0;
            end
    drawnow
end