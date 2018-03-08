function [feature_matrix] = generateFeatureRGB(img)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

feature_matrix = zeros(size(img,1)*size(img,2),3);
counter = 1;
for r = 1:size(img,1)
    for c = 1:size(img,2)
        feature_matrix(counter,:) = img(r,c,:);
        counter = counter+1;
    end 
end

end

