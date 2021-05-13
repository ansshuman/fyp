function disp_result(orig_vid, proc_vid)

    v1 = VideoReader(orig_vid);
    v2 = VideoReader(proc_vid);
    i1 = 0;
    i2 = 0;
    fig = figure('Position', [100, 100, 1000, 1000]);
    ax1 = subplot(2,2,1, 'Parent', fig);
    ax2 = subplot(2,2,2, 'Parent', fig);

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
end