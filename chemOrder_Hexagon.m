%% Utility Functions
latVec = @(a, th) a*[cosd(th), sind(th)];
getR = @(pos) sqrt( pos(:,1).^2 + pos(:,2).^2 );


%% Lattice Vector Setup
a = 3;
b = 4*pi/(sqrt(3)*a);
a1 = latVec(a,0); a2 = latVec(a,120);
b1 = latVec(b,90); b2 = latVec(b, 210); b3 = latVec(b, 330);
r1 = (a1 + 2*a2)/3;
%% Real Space Lattice Grid
numGrid = 10;
[m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
m = m(:); n = n(:);

% Make Triangular Lattice
pos = m*a1 + n*a2;
% pos = m*a1;
pos = [pos; pos(:,1)+r1(1), pos(:,2)+r1(2)];

xRange = [ min(pos(:,1)), max(pos(:,1)) ];
yRange = [ min(pos(:,2)), max(pos(:,2)) ];

rmax = a*numGrid*0.7;%/sqrt(3);
pos( sqrt(pos(:,1).^2+pos(:,2).^2)>rmax,: ) = [];
num_points = size(pos,1);

%% Select q vectors

% Unifrom distribution along K-M-K
Ks(1,:) = (b1-b3)/3;
Ks(2,:) = (b2-b3)/3;
Ks(3,:) = (b2-b1)/3;
Ks(4,:) = (b3-b1)/3;
Ks(5,:) = (b3-b2)/3;
Ks(6,:) = (b1-b2)/3;
Ks(7,:) = Ks(1,:);


qi = [b2(1)/3, b1(2)/2];
qf = [-b2(1)/3, b1(2)/2];
%num_qs = 1.5*10^5;
num_qs_pline = round( num_points*0.57/6 );
num_qs = num_qs_pline * 6;
num_qs = 3;
qs = [];
for i = 1:2:6
    qs = [qs;...
        linspace( Ks(i,1), Ks(i+1,1), num_qs )', linspace(Ks(i,2), Ks(i+1,2), num_qs)' ...
        ];
end


num_qs = length(qs);
% qs = qi;

[h,k] = meshgrid(-3:3, -3:3);
h = h(:); k = k(:);
pos_k = h*b1+ k*b2;
pos_k( getR(pos_k) > 2*b,: ) = [];

figure
hold on
scatter( pos_k(:,1), pos_k(:,2), 20, 'k','filled')
scatter( Ks(:,1), Ks(:,2), 'rx')
scatter( qs(:,1), qs(:,2), 'r.')
axis equal

%%

r_qs = rand([num_qs,2]);
r_qs(:,1) = r_qs(:,1)*( xRange(2)-xRange(1) )+ xRange(1);
r_qs(:,2) = r_qs(:,2)*( yRange(2)-yRange(1) )+ yRange(1);

phs = 2*pi*rand([num_qs,1]);

sigma_q = 8*a;

mod_waves = zeros( [num_points,1] );

for ind_q = 1:num_qs
    cur_rq = r_qs( ind_q,: );
    cur_q = qs(ind_q,:);
    cur_ph = phs(ind_q );

    rdotq = pos(:,1)*cur_q(1) + pos(:,2)*cur_q(2);

%     
    mod_waves = mod_waves + ...
        exp( -0.5*( getR(pos-cur_rq)/sigma_q ).^2).*exp( 1i*(rdotq + cur_ph) );
   % mod_waves = exp( 1i*(rdotq + cur_ph) );
end
%%
Xij = mod_waves;
Xij = real(Xij);
Yij = Xij - mean(Xij);
Yij = Yij/( std(Yij) );

occupancy = Yij>1;

pos_chem = pos(occupancy,:);

figure
hold on
scatter( pos_chem(:,1), pos_chem(:,2), 5,'k','filled');
axis equal


%%
dk = 2.3;
kcx = 0;
kcy = 0;
im_size = 512;
[kx,ky] = meshgrid(linspace((kcx-dk)*b,(kcx+dk)*b,im_size),linspace((kcy-dk)*b,(kcy+dk)*b,im_size));
% takes the fourier sum of the different exp values
ff_lat       = sumPlaneWaves(kx, ky, pos(:,1), pos(:,2) );
ff_chem      = sumPlaneWaves(kx, ky, pos_chem(:,1), pos_chem(:,2) );
%%
figure
imagesc(log(1+abs(ff_chem*1+ff_lat*10).^2))
axis equal