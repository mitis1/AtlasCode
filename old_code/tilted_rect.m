function [r_final] = tilted_rect(r_width,r_height, box_width, box_height, angle)
% r_width = width of rectangle in pixels
% r_height = height of rectangle in pixels
% box_width = unit cell width
% box_height = unit cell height
    mat = ones([r_height, r_width]);
    padding_width = (box_width - r_width);
    padding_height = (box_height - r_height);
    if(mod(padding_width, 2) == 0 && mod(padding_height, 2) == 0)
        r = padarray(mat, [padding_height/2, padding_width/2], 0, 'both');
    elseif(mod(padding_width, 2) ~= 0 && mod(padding_height, 2) == 0)
        r = padarray(mat, [(padding_height)/2, (padding_width-1)/2], 0, 'pre');
        r = padarray(r, [(padding_height)/2, (padding_width+1)/2], 0, 'post');
    elseif(mod(padding_width, 2) == 0 && mod(padding_height, 2) ~= 0)
        r = padarray(mat, [(padding_height-1)/2, (padding_width)/2], 0, 'pre');
        r = padarray(r, [(padding_height+1)/2, (padding_width)/2], 0, 'post');
    else
        r = padarray(mat, [(padding_height-1)/2, (padding_width-1)/2], 0, 'pre');
        r = padarray(r, [(padding_height+1)/2, (padding_width+1)/2], 0, 'post');
    end

    % rotate image
    r_final = imrotate(r, angle, 'crop');
end

 % https://www.imageeprocessing.com/2011/06/image-rotation.html#:~:text=Matlab%20built_in%20function%20rot90(A,270%20and%204%20for%20360.&text=The%20output%20image%20will%20be,rotate%20the%20image%2090%20degrees.