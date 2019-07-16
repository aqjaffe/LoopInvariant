% DESCRIPTION:
%  Testing the distortion H for an ellipse
% AUTHOR:
%  Adam Quinn Jaffe (aqjaffe@stanford.edu)
% LAST EDITED:
%  16 July, 2019

% SETTING THE PARAMETERS
n = 1000;               % number of time discretizations
a = 1;                  % the semimajor/semiminor axes
b = 2;
rs = linspace(0,4,10);   % the Euclidean scales

% SET UP THE CURVE
t = linspace(0,1,n+1);
t = t(1:end-1);
gamma = [a*cos(2*pi*t)' b*sin(2*pi*t)']; % a circle

% RUN THE PROGRAM AND PLOT THE RESULTS
set(gcf, 'Position',  [100, 300, 800, 300])
subplot(1,2,1);
box on;
plot(gamma(:,1),gamma(:,2),'Color','black');
xlabel('$x$-coordinate');
ylabel('$y$-coordinate');
title('Curve $\gamma$')

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
