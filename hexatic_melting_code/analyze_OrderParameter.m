
datanumber = 327254261; % mul = 2, ep = 1.3, iter = 1000, 170, dT = 0.05
load(sprintf('data/%d.mat',datanumber))
addpath('../viewers');
addpath('../logsample');
b = 4*pi/(sqrt(3)*a);
q_IC = b/sqrt(13);


%%
% for indT = 1:numT
%     disp( indT/numT)
%     psis(:, indT)  = calcLDF( posSLs(:,:,indT), xCutoffSL, yCutoffSL);
% end
% PSI6 = mean(psis,1);



figure
% plot( kBTs, abs( PSI6))
% psi_viewer( posSLs, psis, xCutoffSL, yCutoffSL)
%%
rmin = aSL; rmax = xCutoffSL/2;
dr = rmax/100;
rs = rmin:dr:rmax;
r_scal = rs/aSL;

numRs = length(rs);
G6 = zeros( [numRs, numT] );
G6_count = zeros(size(G6));
for indT = 1:numT
    disp( indT/numT)
    posSL = posSLs(:,:,indT);
    psi   = psis(:,indT);
    for indSL = 1:length(posSL)
            disp(indSL)
        psi_cur = psi(indSL);
        pos_cur = posSL(indSL,:);

        dR_nns = pos_cur - posSL;
        dR_nns(:,1) = dR_nns(:,1) - round(dR_nns(:,1) / xCutoffSL) * xCutoffSL;
        dR_nns(:,2) = dR_nns(:,2) - round(dR_nns(:,2) / yCutoffSL) * yCutoffSL;
        r_nns = sqrt(dR_nns(:,1).^2 + dR_nns(:,2).^2);
        
        for indR = 1:numRs
            curR = rs(indR);
            G6_cur = abs(sum( psi_cur*conj(psi( r_nns>(curR-dr/2) & r_nns<=(curR+dr/2) ))));
            if isnan(G6_cur)
                G6_cur = 0;
            end
            cur_count = sum(r_nns>(curR-dr/2) & r_nns<(curR+dr/2));
            if isnan(cur_count)
                cur_count = 0;
            end
            G6_count(indR,indT) = G6_count(indR,indT) + cur_count;
            G6(indR,indT) = G6(indR,indT) + G6_cur;
        end
    
    end
    
    
    

end

G6 = G6./G6_count;
G6( isnan(G6) ) = 0;
save(sprintf('data/%d_OP.mat',datanumber),'r_scal','G6','psis','r_scal','rs')
%%
load(sprintf('data/%d_OP.mat',datanumber))

colStart = [0, 0, 0]/255;
colEnd   = [255, 37, 0]/255;

figure
ax = gca;
hold( ax,'on')
for indT = 2:numT
    
    colCur = colStart + (indT/numT)*(colEnd-colStart);
    
    
    plot(r_scal,abs(G6(:,indT)),'color',colCur,'linewidth',2)

    text(r_scal(end)+5, abs(G6(end,indT)), sprintf('kBT = %d',round(kBTs(indT))), 'FontSize',12)

end
plot(r_scal, 0.3*((r_scal).^(-0.25)),'b--','linewidth',3)
text(r_scal(end), 0.3*((r_scal(end)).^(-0.25))+0.02,'\propto r^{-1/4}','color','blue', 'FontSize',12)



xticks([1:9,10:10:100])
yticks([0,0.01,0.1,1])
set(ax, 'YScale', 'log')
set(ax, 'XScale', 'log')
xlabel('Distance (r/a)')
ylabel('G6')



figure
scatter( posSL(:,1), posSL(:,2), 150, abs(psi),'.')