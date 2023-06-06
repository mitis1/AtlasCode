function PSI6 = calcPSI6( posSL, xCutoffSL, yCutoffSL)
    PSI6 = 0;
    numSiteSL = size(posSL,1);
    for indSL = 1:numSiteSL

        pos_cur = posSL(indSL,:);

        dR_nns = pos_cur - posSL;
        dR_nns(:,1) = dR_nns(:,1) - round(dR_nns(:,1) / xCutoffSL) * xCutoffSL;
        dR_nns(:,2) = dR_nns(:,2) - round(dR_nns(:,2) / yCutoffSL) * yCutoffSL;

        r_nns = (dR_nns(:,1).^2 + dR_nns(:,2).^2);
        
        dR_nns = sortrows( [dR_nns, r_nns], 3);
        psi6s = exp( 6i*( atan2(dR_nns(2:7,2),dR_nns(2:7,1)) ) );

        PSI6 = sum(psi6s(:))/6 + PSI6;

        
    end
        


    PSI6 = PSI6/numSiteSL;

end