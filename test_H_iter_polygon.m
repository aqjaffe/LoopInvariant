% DESCRIPTION:
%  Iterating the H map (for fixed r)
% AUTHOR:
%  Adam Quinn Jaffe (aqjaffe@stanford.edu)
% LAST EDITED:
%  16 July, 2019

% SETTING THE PARAMETERS
n = 1008;   % number of time discretizations
N = 7;      % number of sides of the polygon
r = 1.628;  % the Euclidean scales
ell = 1;    % the winding number

% SET UP THE CURVE
if mod(n,N) ~= 0
    error('Number of sides (%d) does not divide time discretization (%d)',N,n);
end
if N < 4*ell + 2
    error('Number of sides (%d) is too small for inscribed %d-stars to exist',N,2*ell+1);
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

% Plot the polygon
set(gcf, 'Position',  [50, 400, 1350, 350])
subplot(1,3,1);
box on;
plot(gamma(:,1),gamma(:,2),'Color','black');
xlabel('$x$-coordinate');
ylabel('$y$-coordinate');
title('Curve $\gamma$')

% Plot the disortion function
subplot(1,3,2);
hold on;
box on;
vals = unwrap(t,H(t,gamma,r),1);
plot(t,vals,'Color','red');
xlabel('paramter $s$');
title('$H_{\gamma}(r,t) = g_r(t)$');

% Plot the iterated distortion funcion
shifts = zeros(1,2*ell);
for ii = 1:(2*ell)
    vals = unwrap(mod(vals,1),H(mod(vals,1),gamma,r),1)+floor(vals);
end
subplot(1,3,3);
hold on;
box on;
plot(t,vals,'Color','red');
plot(t,t+ell,'Color','blue');
xlabel('paramter $s$');
title(sprintf('$g_r^%d(t)$', 2*ell+1));
