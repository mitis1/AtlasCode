function im = soft_ngon(xx, yy, n, s, sg) 
    % Implement this.
    r = s/(2*sin(pi/n));
    theta = linspace(0, 2*pi, n+1);
    theta(end) = [];

    px = r .* cos(theta);
    py = r .* sin(theta);
    
    im = double(poly2mask(px+N/2, py+N/2, N, N));
    im = imgaussfilt(im, sg, 'FilterDomain', 'frequency');
end


% obj = zeros(size(xx));
% for i = 1:n
%     j = i + 1;
%     if (j > size(px, 2)); j = 1; end
%     m = (py(j)-py(i))/(px(j)-px(i));
%     obj1 = -(erf( (m*(xx-px(i)) - (yy-py(i)) )/sg) );
%     if(i == 1); obj = obj1; continue; end
%     obj = obj .* obj1;
% end