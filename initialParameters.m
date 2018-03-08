function [mew, sigma , weights] = initialParameters(feature_matrix,no_of_classes)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    max_val = max(max(feature_matrix));
    min_val = min(min(feature_matrix));
    dim = size(feature_matrix,2);
    mew = randi([min_val max_val],dim,no_of_classes);
    
    sigma = zeros(dim,dim,no_of_classes);
    
    for i = 1:no_of_classes
        rand_matrix = rand(dim);
        sigma(:,:,i) = rand_matrix'*rand_matrix;
    end
    sigma = sigma.*100;
    
    weights = rand(no_of_classes,1);
    weights = weights/sum(weights);

end

