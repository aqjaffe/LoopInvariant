function out = H(t,gamma,r)
    % DESCRIPTION
    %  Determines the coordinate distance traversed
    %  by jumps of a given Euclidean distance 
    % INPUTS
    %  t     --- the time discretization of the loop
    %  gamma --- the vaues of the loop
    %  r     --- the scale of the Euclidean jump
    % OUTPUTS
    %  out   --- the output
    n = length(t);
    out = zeros(n,1);
    for ii = 1:n
        jj = mod(ii,n) + 1;
        while norm(gamma(jj,:) - gamma(ii,:)) < r && jj ~= ii
            jj = mod(jj,n) + 1;
            if jj == ii
                break;
            end
        end
        if jj == ii
            out(ii) = t(ii)+1;
        else
            out(ii) = t(mod(jj-2,n) + 1);
        end
    end
end

