function [px,py] = disorder_px(angle, scale_a2, scale_div, pts, line, num_pts, N)
% angle is the one in a2 latvector
% scale_a2 is what a2 is being multipled by
% scale_div is what a1+a2 is being divided by 
% pts is the positions for the disorder -> 1, 2, 3, 5, 6
% line means if its line or points
% if it is a point, then num pts is number of points per segment
%% Utility Functions
latVec = @(a, th) a*[cosd(th), sind(th)];
getR = @(pos) sqrt( pos(:,1).^2 + pos(:,2).^2 );


%% Lattice Vector Setup
a = 3;
b = 4*pi/(sqrt(3)*a);
a1 = latVec(a,0); a2 = latVec(a,angle);
b1 = latVec(b,90); b2 = latVec(b, 210); b3 = latVec(b, 330);
r1 = (a1 + scale_a2*a2)/scale_div;
%% Real Space Lattice Grid
numGrid = 20;
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
if(line)
    num_qs = num_qs_pline *12;
else
    num_qs = num_pts;
end
qs = [];
for i = 1:size(pts,2)
    qs = [qs;...
        linspace( Ks(pts(i),1), Ks(pts(i)+1,1), num_qs )', linspace(Ks(pts(i),2), Ks(pts(i)+1,2), num_qs)' ...
        ];
end


num_qs = length(qs);
% qs = qi;

[h,k] = meshgrid(-3:3, -3:3);
h = h(:); k = k(:);
pos_k = h*b1+ k*b2;
pos_k( getR(pos_k) > 2*b,: ) = [];

% figure
% hold on
% scatter( pos_k(:,1), pos_k(:,2), 20, 'k','filled')
% scatter( Ks(:,1), Ks(:,2), 'rx')
% scatter( qs(:,1), qs(:,2), 'r.')
% axis equal

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
px = pos_chem(:,1);
py = pos_chem(:,2);
if(size(pts) == [0,0])
    px = pos(:,1);
    py = pos(:,2);
end
ratio = N/max(max(px)-min(px), max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
px1 = px;
px(abs(px1)>=N/2) = [];
py(abs(px1)>=N/2) = [];
end