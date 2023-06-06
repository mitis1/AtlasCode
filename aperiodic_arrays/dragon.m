function M=dragon(iters,theta)
%function M=dragon(iters,theta)
% Draws the dragon fractal for a given number ITERS of iterations using a
% 'twist' angle of theta
% ITERS - Number of iterations (a positive integer)
% THETA - Angle of Twist (0 to 2*pi)
%
% Example :
% dragon(15,pi/2)
%
% Created by S. Janardhanan
% Last Updated : 01 May 2012
%Error Checking
M=[-1 0];
angles=cos(theta)+j*sin(theta);
for i=1:iters
    M1=angles*M((end-1):-1:1);
    M=[M M1];
    Mr=max(real(M));
    mr=min(real(M));
    Mi=max(imag(M));
    mi=min(imag(M));
    ra=(Mr+mr)/2;
    ia=(Mi+mi)/2;
    rr=Mr-ra;
    ir=Mi-ia;
    M=M-(ra+j*ia);
    M=M/(rr*ir)^.5;
    M=M-M(end);
end
d=unique(real(M));
for i=1:length(d)
    th=d(i);
    q=find(real(M)==th);
    qi=imag(M(q));
    qi=sort(qi);
    md=min(abs(diff(qi)));
    dq=find(abs(diff(qi))>md);
    qi=[qi(1) qi(dq+1)];
    plot(th+j*qi,'.')
    hold on
   % pause
end
axis off
    