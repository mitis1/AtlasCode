%Read multislice output and convert to complex matrix
clear all

fname_base = 'aslic_out_rectGraphene';
fname_base = 'aslic_out_rTBGPLD_1.2029_10coef_0.150Ang';

mul = imread([fname_base,'.tif'],2);
[nr,nc] = size(mul);

mul_real = mul(:,1:nc/2);
mul_imag = mul(:,nc/2+1:nc);

mul_comp = mul_real + 1i*mul_imag;


%take 2d fft and shift 0 to center
mul_FFT = fftshift(fft2(mul_comp));

%separate amplitude and phase
amp = abs(mul_FFT);
amp = amp-min(amp(:));
amp = amp/max(amp(:));
pha = angle(mul_FFT);

%remove center beam
amp(amp == max(amp(:))) = 0;
amp = amp/max(amp(:));
amp(amp<=0.01) =0 ;

%diffraction pattern
diff = amp.^2;

% [rcenter,ccenter] = find(diff == max(diff(:)));
% zb = 30;
% diff(rr2<zb^2) = 0;
% amp(rr2<zb^2) = 0;
% diff(rcenter-zb:rcenter+zb,ccenter-zb:ccenter+zb) = 0;
% amp(rcenter-zb:rcenter+zb,ccenter-zb:ccenter+zb) = 0;

figure
imagesc((diff))
colormap('gray')
axis equal


%labspace
L = amp;
L = L*300;
a = L .* cos(pha);
b = L .* sin(pha); 


labim(:,:,1) = L;
labim(:,:,2) = a;
labim(:,:,3) = b;
rgbim = lab2rgb(labim);

rgb_blured = zeros(size(rgbim));



maxrgb = max(rgbim(:));
for i = 1:3
    rgb_blured(:,:,i) = imgaussfilt(rgbim(:,:,i),2);
end
rgb_blured = rgb_blured/max(rgb_blured(:))*maxrgb;

figure
imshow(rgb_blured)
