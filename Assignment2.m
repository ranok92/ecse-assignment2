img1 = imread('69020.jpg');

feature_matrix = generateFeatureIntensity(img1);

labels = EMSegmentation(feature_matrix,4);



