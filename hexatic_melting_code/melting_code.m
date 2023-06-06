function data_num = melting_code(mul, ep, numIter, T_start, dT)
%% Mode


rng('shuffle')
sd = rng; 

% Ts = 300+(0:(1104-1))*(-0.2) + 273; % actual temp range in K (to comapre to data)

%% Tools
getR = @(x) sqrt( x(:,1).^2 + x(:,2).^2 );

%% Grid Setup
numGridLT = 200;   m = (-numGridLT:numGridLT);
[m,n] = meshgrid(m,m);
numGridSL = floor(numGridLT/2);  j = (-numGridSL:numGridSL);
[j,k] = meshgrid(j,j);

m = m(:); n = n(:); j = j(:); k = k(:);

th = 0;
a = 3; a1 = a*[cosd(th), sind(th)]; a2 = a*[cosd(th+120),sind(th+120)];
aSL = sqrt(13)*a;
SL1 = aSL*[cosd(0), sind(0)]; SL2 = aSL*[cosd(120), sind(120)];

sg = aSL/2;

% posLT = m*a1 + n*a2;
posSL = j*SL1 + k*SL2;

xCutoffSL = aSL*21; yCutoffSL = xCutoffSL/7*4*sqrt(3);
xCutoffSL = mul*xCutoffSL; yCutoffSL = mul*yCutoffSL;

rd = 4;
a1 = round(a1,rd); a2 = round(a2,rd);
aSL = round(aSL,rd); SL1 = round(SL1, rd); SL2 = round(SL2, rd);
% posLT = round( posLT,rd); posSL = round( posSL, rd);
xCutoffSL = round( xCutoffSL, rd); yCutoffSL = round( yCutoffSL, rd);

posSL( posSL(:,1) >=  xCutoffSL ,: ) = [];
posSL( posSL(:,1) <   0         ,: ) = [];
posSL( posSL(:,2) >=  yCutoffSL ,: ) = [];
posSL( posSL(:,2) <   0         ,: ) = [];

% rposLT = sqrt( (posLT(:,1)-xCutoffSL/2).^2 + (posLT(:,2)-yCutoffSL/2).^2);

% posLT( rposLT > xCutoffSL/2*0.7, : ) = [];

% numSiteLT = length(posLT);
numSiteSL = length(posSL);

%% Monte Carlo Setup

% Truncated LJ Potential
sgLJ = 1.5*aSL*(2^(-1/6));
A = 4*ep*sgLJ^12;
B = 4*ep*sgLJ^6;
r_c = sqrt(3)*aSL;


% Iteration Setup
kBTs = [(0:dT:2.2)] *abs(ep)*T_start;
numT = length(kBTs);
iter = numIter*ones([numT,1]);
iter(1) = 0;

% Random Deviation Limit
delta = aSL*0.1;

Psi6s     = zeros(numT,1);
% posLT_PLD = zeros([size(posLT),numT]);
posSLs    = zeros([size(posSL),numT]);
pldScal = 0.1;

%% Iterate
for indT = 1:numT
    kBT = kBTs(indT);
    tic
    fprintf('%d/%d\n',indT,numT)
    
    for ct = 1:iter(indT)
        
        for indSL = 1:numSiteSL
            pos_cur = posSL(indSL,:);
            dPos = round(delta*(2*rand(1,2)-1),rd);
            
            dR_nns = pos_cur - posSL;
            dR_nns(:,1) = dR_nns(:,1) - round(dR_nns(:,1) / xCutoffSL) * xCutoffSL;
            dR_nns(:,2) = dR_nns(:,2) - round(dR_nns(:,2) / yCutoffSL) * yCutoffSL;
            
            r_nns = getR(dR_nns);
            dR_nns( r_nns > r_c | r_nns <= 0, :) = [];
            dR_nns_new = dR_nns + dPos;
            r_nns_cur = getR(dR_nns);
            r_nns_new = getR(dR_nns_new);

            dE = sum(V_LJ(r_nns_new, A, B,r_c)) - sum(V_LJ(r_nns_cur, A, B,r_c));

            if rand() < exp(-dE/(kBT))
                pos_new = pos_cur + dPos;
                posSL(indSL,1) = pos_new(1) - floor(pos_new(1)/xCutoffSL)* xCutoffSL;
                posSL(indSL,2) = pos_new(2) - floor(pos_new(2)/yCutoffSL)* yCutoffSL;
            end
        end
        
    end
    posSLs(:,:,indT)    = posSL;
%     posLT_PLD(:,:,indT) = calcPLD_gaussian(posLT, posSL, aSL/2, aSL/2, pldScal);
    
    toc
end

%%
save( sprintf('data/%d.mat',(sd.Seed)) )
data_num = sd.Seed;


end

