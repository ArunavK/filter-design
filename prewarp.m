function [Wp_warp, Ws_warp] = prewarp(wp, ws)
    
    fprintf("Input frequencies:\n");
    fprintf("passband frequency = %0.4f Hz or %0.4f rad/s\n", wp/(2*pi), wp);
    fprintf("stopband frequency = %0.4f Hz or %0.4f rad/s\n", ws/(2*pi), ws);
    
    Wp_warp = tan(wp/2);
    Ws_warp = tan(ws/2);

    fprintf("Warped frequencies:\n");
    fprintf("warped passband = %0.4f Hz or %0.4f rad/s\n", Wp_warp/(2*pi), Wp_warp);
    fprintf("Warped stopband = %0.4f Hz or %0.4f rad/s\n", Ws_warp/(2*pi), Ws_warp);
    
    