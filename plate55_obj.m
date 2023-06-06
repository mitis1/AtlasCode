function obj = plate55_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx,yy] = meshgrid(x, x);
r = 10;
latVec = @(a, th) a*[cosd(th), sind(th)];
circle_funct = @() draw_circle(xx, yy, r, sg);
%mul, ep, iter, startT, dT
% datanumber = melting_code(1,1.3,100,170,0.2); % mul = 1, ep = 1.3, iter = 100, 170, dT = 0.2
datanumber = 327254261;
load(sprintf('hexatic_melting_code/data/%d.mat',datanumber),"posSLs");
% if(row == 1 && col == 1)
%     indT = 1;
% elseif(row == 1 && col == 2)
%     indT = 2;
% elseif(row == 1 && col == 3)
%     indT = 3;
% elseif(row == 2 && col == 1)
%     indT = 4;
% elseif(row == 2 && col == 2)
%     indT = 5;
% elseif(row == 2 && col == 3)
%     indT = 6;
% elseif(row == 3 && col == 1)
%     indT = 7;
% elseif(row == 3 && col == 2)
%     indT = 8;
% elseif(row == 3 && col == 3)
%     indT = 9;
% elseif(row == 4 && col == 1)
%     indT = 10;
% elseif(row == 4 && col == 2)
%     indT = 11;
% elseif(row == 4 && col == 3)
%     indT = 12;
% end
indT = 6;
if(row == 1 && col == 1)
    indT = 1;
end
pos = posSLs(:,:,indT);




%% Apply PLD
if(row == 1 && col == 1)
    pld = zeros( size(pos) );

elseif(row == 1 && col == 2)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];

    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-0.1);
    %     A = [q(i,2),-q(i,1)]/q_mag*(-1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 1 && col == 3)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-1);
        A = [q(i,2),-q(i,1)]/q_mag*(-0.1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 2 && col == 1)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-1);
        A = [q(i,2),-q(i,1)]/q_mag*(-1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 2 && col == 2)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-1);
%         A = [q(i,2),-q(i,1)]/q_mag*(-0.1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 2 && col == 3)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-1);
        A = [q(i,2),-q(i,1)]/q_mag*(-2);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 3 && col == 1)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,rand(1,1)*360)];

    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-0.1);
        A = [q(i,2),-q(i,1)]/q_mag*(-0.1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 3 && col == 2)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    % q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    q = [latVec(q_mag,rand(1,1)*360); latVec(q_mag,rand(1,1)*360); latVec(q_mag,rand(1,1)*360);...
        latVec(q_mag,rand(1,1)*360); latVec(q_mag,rand(1,1)*360)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-0.1);
        A = [q(i,2),-q(i,1)]/q_mag*(-0.1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 3 && col == 3)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    % q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    q = [latVec(q_mag,rand(1,1)*360); latVec(q_mag,rand(1,1)*360); ...
        latVec(q_mag,rand(1,1)*360); latVec(q_mag,rand(1,1)*360)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        if(i == 1 || i == 2)
            A = q(i,:)/q_mag*(-0.1);
        else
            A = [q(i,2),-q(i,1)]/q_mag*(-0.1);
        end
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 4 && col == 1)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    % q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    q = [latVec(q_mag,0)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-0.1);
        theta = 360*rand(1,1); % to rotate 90 counterclockwise
        R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
        A = A*R;
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 4 && col == 2)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-0.1);
        theta = 360*rand(1,1); % to rotate 90 counterclockwise
        R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
        A = A*R;
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 4 && col == 3)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-1);
        theta = 360*rand(1,1); % to rotate 90 counterclockwise
        R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
        A = A*R;
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
end

px = pos(:,1)+pld(:,1);
py = pos(:,2)+pld(:,2);
ratio = N/(max(py)-min(py));
if(row == 2 && col == 2)
    ratio = N*1.5/(max(py)-min(py));
end
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
obj = zeros(size(xx));
for i = 1:size(px,1)
    obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
end
end

% 327254261: mul = 1, ep = 1.3, iter = 100, 170, dT = 0.2