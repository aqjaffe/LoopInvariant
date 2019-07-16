% DESCRIPTION:
%  Testing the distortion H for the regular polygons
% AUTHOR:
%  Adam Quinn Jaffe (aqjaffe@stanford.edu)
% LAST EDITED:
%  16 July, 2019

% SETTING THE PARAMETERS
n = 1002;               % number of time discretizations
N = 6;                  % number of sides of the polygon
rs = linspace(0,1.999,10);  % the Euclidean scales

% SET UP THE CURVE
if mod(n,N) ~= 0
    error('Number of sides (%d) does not divide time discretization (%d)',N,n);
end
t = linspace(0,1,n+1);
t = t(1:end-1);
gamma = zeros(n+1,2);
for ii = 1:N
    xslope = cos(2*pi*ii/N) - cos(2*pi*(ii-1)/N);
    xinit = cos(2*pi*(ii-1)/N);
    yslope = sin(2*pi*ii/N) - sin(2*pi*(ii-1)/N);
    yinit = sin(2*pi*(ii-1)/N);
    gamma(1+n*(ii-1)/N:1+n*ii/N,1) = xinit + xslope*t(1:1+n/N)/(t(1+n/N)-t(1));
    gamma(1+n*(ii-1)/N:1+n*ii/N,2) = yinit + yslope*t(1:1+n/N)/(t(1+n/N)-t(1));
end
gamma = gamma(1:end-1,:);

% RUN THE PROGRAM AND PLOT THE RESULTS
set(gcf, 'Position',  [100, 300, 800, 300])
subplot(1,2,1);
box on;
plot(gamma(:,1),gamma(:,2),'Color','black');
xlabel('$x$-coordinate');
ylabel('$y$-coordinate');
title('Curve $\gamma$')

% RUN THE PROGRAM AND PLOT THE RESULTS
subplot(1,2,2);
hold on;
box on;
cm = colormap(winter(length(rs)));
for ii = 1:length(rs)
    unwrapped_H = unwrap(t,H(t,gamma,rs(ii)),1);
    plot(t,unwrapped_H,'Color', cm(ii,:));
end
xlabel('parameter $s$');
title('$H(r,s)$');
colorbar('Ticks',[0,1],'TickLabels',{sprintf('$r=%0.2f$',...
    rs(1)),sprintf('$r=%0.2f$',rs(end))},'TickLabelInterpreter','latex');
