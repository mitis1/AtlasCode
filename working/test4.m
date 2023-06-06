N = 256;
% N_padded = 512;
x = -N/2:N/2-1;
[xx,yy,zz] = meshgrid(x,x,x);
numAtoms = 8;
spacing = N/numAtoms;
r = 6;
sg = 2;
xp = linspace(-N/2 + (r+sg)*2 - 0.5, N/2-1 - (r+sg)*2 + 0.5, numAtoms);
[px, py, pz] = meshgrid(xp, xp, xp);

totalVolume = zeros(size(xx));
for k = 1:size(px,3)
    tic
    for j = 1:size(px,2)
        for i = 1:size(px,1)
            randy = rand(1,1)*spacing/4 - spacing/8;
            randx = rand(1,1)*spacing/4 - spacing/8;
            randz = rand(1,1)*spacing/4 - spacing/8;

%             randy = 0;
%             randx = 0;
%             randz = 0;
            rr = sqrt((xx-px(i,j,k)+randx).^2 + (yy-py(i,j,k)+randy).^2 + (zz-pz(i,j,k)+randz).^2 );
            im = erfc( (rr-r)/sg ) / 2 ;
            totalVolume = totalVolume + im;
        end
    end
    toc
end
%%
N_padded = 256;
% obj = padarray(totalVolume, [256/2, 256/2, 256/2], 'both');
% rr = sqrt((xx).^2 + (yy).^2 + (zz).^2 );
% obj = erfc( (rr-128)/sg)/2;
totalVol_fft = fftshift(fftn(ifftshift(totalVolume)));
obj_amp = abs(totalVol_fft);

zoom_factor = 4;

contrast_min = 98;
contrast_max = 99.98;

obj_amp = rescale(obj_amp);
val_range = prctile(obj_amp, [contrast_min contrast_max], 'all');
if(val_range(1) ~= val_range(2) || plates(1) ~= 41)
    obj_amp = imadjustn(obj_amp, [val_range(1) val_range(2)], [0 1]);
end

crop_start = (N_padded)/2 - ((N_padded)/(zoom_factor*2)) + 1;
crop_end = (N_padded)/2 + ((N_padded)/(zoom_factor*2));
obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end, crop_start:crop_end);