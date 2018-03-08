function [feature_matrix] = generateFeatureLAB(img)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

img = rgb2lab(img);
feature_matrix = zeros(size(img,1)*size(img,2),2);
counter = 1;
for r = 1:size(img,1)
    for c = 1:size(img,2)
        feature_matrix(counter,:) = img(r,c,2:3);
        counter = counter+1;
    end 
end

end

