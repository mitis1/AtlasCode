DIM = [N N];
BETA = 4;
u = [(0:floor(DIM(1)/2)) -(ceil(DIM(1)/2)-1:-1:1)]'/DIM(1);
% Reproduce these frequencies along ever row
u = repmat(u,1,DIM(2));
% v is the set of frequencies along the second dimension.  For a square
% region it will be the transpose of u
v = [(0:floor(DIM(2)/2)) -(ceil(DIM(2)/2)-1:-1:1)]/DIM(2);
% Reproduce these frequencies along ever column
v = repmat(v,DIM(1),1);
% Generate the power spectrum
S_f = (u.^2 + v.^2).^(BETA/2);
% Set any infinities to zero
S_f(S_f==inf) = 0;
% Generate a grid of random phase shifts
phi = rand(DIM);
% Inverse Fourier transform to obtain the the spatial pattern
x = ifft2(S_f.^0.5 .* (cos(2*pi*phi)+i*sin(2*pi*phi)));
% Pick just the real component
x = real(x);

obj = x .^ 2;