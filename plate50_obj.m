function obj = plate50_obj(row, col, N, sg)
latVec = @(a, th) a*[cosd(th), sind(th)];
% row 1 - hexagonal lattice, longitudianal, latidudinal
% row 2 - same as row 1 but square lattice

if(row == 1 && col == 1)
    % Lattice Vector Setup
    a = 3; b = 4*pi/(sqrt(3)*a);
    q_mag = b/sqrt(3);
    a1 = latVec(a,0); a2 = latVec(a,120);
    q = [latVec(q_mag,30); latVec(q_mag, 150); latVec(q_mag, 270)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    pld = zeros( size(pos) );

elseif(row == 1 && col == 2)
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
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
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
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
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
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
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
    a1 = latVec(a,0); a2 = latVec(a,90);
    q = [latVec(q_mag,0); latVec(q_mag, 90)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
elseif(row == 3 && col == 2)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,90);
    q = [latVec(q_mag,0); latVec(q_mag, 90)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-0.1);
    %     A = [q(i,2),-q(i,1)]/q_mag*(-1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 3 && col == 3)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,90);
    q = [latVec(q_mag,0); latVec(q_mag, 90)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-0.1);
        A = [q(i,2),-q(i,1)]/q_mag*(-0.1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 4 && col == 1)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,90);
    q = [latVec(q_mag,0); latVec(q_mag, 90)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
        A = q(i,:)/q_mag*(-1);
    %     A = [q(i,2),-q(i,1)]/q_mag*(-1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 4 && col == 2)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,90);
    q = [latVec(q_mag,0); latVec(q_mag, 90)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-0.1);
        A = [q(i,2),-q(i,1)]/q_mag*(-1);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
elseif(row == 4 && col == 3)
    % Lattice Vector Setup
    a = 3; b = 2*pi/a;
    q_mag = b/4;
    a1 = latVec(a,0); a2 = latVec(a,90);
    q = [latVec(q_mag,0); latVec(q_mag, 90)];
    
    numGrid = 10;
    [m,n] = meshgrid(-numGrid:numGrid, -numGrid:numGrid);
    m = m(:); n = n(:);
    pos = m*a1 + n*a2;
    
    pld = zeros( size(pos) );
    for i = 1:size(q,1)
%         A = q(i,:)/q_mag*(-0.1);
        A = [q(i,2),-q(i,1)]/q_mag*(-2);
        pld(:,1) = pld(:,1)+ A(1)*sin( pos*q(i,:)');
        pld(:,2) = pld(:,2)+ A(2)*sin( pos*q(i,:)');
    end
end


px = pos(:,1)+pld(:,1); py = pos(:,2)+pld(:,2);
ratio = N*1.5/(max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;

obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r_circle = 5;
obj_funct = @() draw_circle(xx, yy, r_circle, sg);
for i = 1:size(px,1)
    obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
end
end