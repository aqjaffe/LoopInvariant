function unwrapped = unwrap(t,vals,width)
    % DESCRIPTION
    %  Forces a collection of values to
    %  fall between the lines t and t + width
    % INPUTS
    %  t      --- the inputs
    %  vals   --- the values to be unwrapped
    %  width  --- the with of the unwrapped values
    % OUTPUTS
    %  unwrapped   --- the unwrapped values
    n = length(vals);
    unwrapped = vals;
    for ii = 2:n
        if vals(ii) < t(ii)
            unwrapped(ii) = unwrapped(ii) + width;
        end
    end
end