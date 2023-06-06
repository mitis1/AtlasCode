N = 812;
N_padded = 4096;

% plate 41
% N = 812;
% N_padded = 812;
sg = 2;
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);

spacing = 58;
x1 = -N/2:spacing:N/2;
[px, py] = meshgrid(x1, x1);

r_circle = 5;
r_circle2 = 10;
obj_funct1 = @() draw_circle(xx, yy, r_circle, sg);
obj_funct3 = @() draw_circle(xx, yy, r_circle2, sg);

magx = 0;
magy = 0.5;
probx = 0;
proby = 0.25;

count = 1;
for i = 1:size(px, 1)
    for j = 1:size(px, 2)
        if(count <= 4)
            obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            count = count + 1;
        else
            rand_offsetx = rand(1,1)*spacing*magx;
            rand_offsety = rand(1,1)*spacing*magy;
            if(rand(1,1) <= probx)
                if(rand(1,1) <= proby)
                    obj = obj + imtranslate(obj_funct3(), [px(i, j)+rand_offsetx, py(i, j)+rand_offsety], 'bilinear');
                    count = count - 1;
                else
                    obj = obj + imtranslate(obj_funct3(), [px(i, j)+rand_offsetx, py(i, j)], 'bilinear');
                    count = count - 1;
                end
            elseif(rand(1,1) <= proby)
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)+rand_offsety], 'bilinear');
                count = count - 1;
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
                count = count - 1;
            end
        end
    end
end
obj1 = obj;

%%
obj = obj1;
noise_mean = 0;
noise_variance = 0.005;

zoom_factor = 8;
contrast_min = 98;
contrast_max = 99.98;


    % Display object
    dispobj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
    dispobj = (rescale( -dispobj ) );
    figure(1)
    hold on;
    imagesc(dispobj);
    colormap( 'gray')
%     axis square;
    hold off;
    xs = -N/2:N/2-1;
    [xx,yy] = meshgrid( xs,xs );
    obj = obj .* draw_circle(xx, yy, 400, 10);
    obj = padarray(obj, [(N_padded-N)/2, (N_padded-N)/2], 'both');
    obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
    obj_fft = fftshift(fft2(ifftshift(obj)));
    
    obj_amp = abs(obj_fft);
    obj_amp = rescale(obj_amp);
    val_range = prctile(obj_amp, [contrast_min contrast_max], 'all');
    
    %cropping fourier transform
    crop_start = (N_padded)/2 - ((N_padded)/(zoom_factor*2)) + 1;
    crop_end = (N_padded)/2 + ((N_padded)/(zoom_factor*2));
    obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);
    
    obj_pha = angle(obj_fft) + pi/2;
    obj_pha = obj_pha(crop_start:crop_end, crop_start:crop_end);

    L = 100 * (obj_amp);

    a = L.*cos(obj_pha);
    b = L.*sin(obj_pha);
    pha_rgb = lab2rgb( cat(3, L, a, b));
    pha_rgb( pha_rgb>1 ) = 1;
    pha_rgb( pha_rgb<0 ) = 0;


    figure
    imagesc(pha_rgb)
